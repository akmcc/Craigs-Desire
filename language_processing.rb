require 'treat'


class LangProcessor

  include Treat::Core::DSL
  attr_reader :pdx_prob, :nyc_prob, :pdx_nouns, :nyc_nouns

  def initialize
    @pdx_prob = Marshal.load(Stats.last.pdx_probability)
    @nyc_prob = Marshal.load(Stats.last.nyc_probability)
    @pdx_nouns = Marshal.load(Stats.last.pdx_nouns)
    @nyc_nouns = Marshal.load(Stats.last.nyc_nouns)
  end

  def generic_post(probabilities)
    current = "None"
    post = ""
    next_word = sample_word(probabilities[current])
    until post.size > 410 && next_word == nil
      if next_word == nil
        next_word = sample_word(probabilities["None"])
      else
        if next_word.match(/[\,\.\;\:\-\!\?]/)
          post << next_word
        else
          post << " #{next_word}"
        end
        current = next_word
        next_word = sample_word(probabilities[current])
      end
    end
    post
  end

def sample_word(probability_hash)
  score = rand(0)
  while true
    probability_hash.each do |word, prob|
      if score < prob
        return word
      else
        score -= prob
      end
    end
  end
end

def find_probability(counted_bigrams)
  probability = {}
  counted_bigrams.each do |key, count_hash|
    count_hash.each do |inner_key, value|
      probability[key] ||= {}
        #set probability of each word by diving it's count by the count of all words in that hash
        probability[key][inner_key] = (value.to_f / counted_bigrams[key].values.inject(0){|a,b| a + b}.to_f)
      end
    end
    probability
  end

  def count_bigrams(tokenized_stories)
    count = {}
    tokenized_stories.each do |sent|
      sent = ["None"] + sent
      # creates the bigrams by zipping the sentenece together w/ subset of sentence
      sent.zip(sent[1..-1]).each do |current, on_deck|
        count[current] ||= {}
        count[current][on_deck] ||= 0
        count[current][on_deck] += 1
      end
    end
    count
  end

  def tokenize(document)
    document.apply(:chunk, :segment, :tokenize, :category)
    tokenized_sentences = []
    document.sentences.each do |sent|
      tokenized_sentences << sent.to_a
    end
    tokenized_sentences
  end

  def find_word_popularity(document)
    word_frequency = {}
    unique_words = document.words.map {|word| word.to_s.downcase}.uniq
    unique_words.each do |w|
      word_frequency[w] = document.frequency_of(w)
    end
    word_frequency
  end

  def find_noun_popularity(word_frequency_hash)
    word_frequency_hash.select do |key, value|
      key.category == 'noun'
    end
  end

  def most_common_nouns(nouns)
    all_sorted = nouns.sort_by {|key, value| value}.reverse
    all_sorted[0..20]
  end

  def get_text_from(city)
    text = ""
    Post.where(city: "#{city}").each do |post|
      text << post.body
    end
    File.open("#{city.delete(' ')}_text.txt", 'w'){|file| file.write(text)}
  end

  def update_stats
    get_text_from("Portland")
    get_text_from("New York City")
    pdx_doc = document 'Portland_text.txt'
    nyc_doc = document 'NewYorkCity_text.txt'
    stat = Stats.last
    stat.pdx_probability = Marshal.dump(find_probability(count_bigrams(tokenize(pdx_doc))))
    stat.nyc_probability = Marshal.dump(find_probability(count_bigrams(tokenize(nyc_doc))))
    stat.pdx_nouns = Marshal.dump(find_noun_popularity(find_word_popularity(pdx_doc)))
    stat.nyc_nouns = Marshal.dump(find_noun_popularity(find_word_popularity(nyc_doc)))
    stat.save
  end
end


