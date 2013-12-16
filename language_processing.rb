require 'treat'
require_relative './post_probs'

class LangProc

  include Treat::Core::DSL
  attr_reader :probability_hash, :adjective_popularity

  def initialize
    @probability_hash = PostStats.new.post_probs
    @adjective_popularity = PostStats.new.post_adj_pop
    @story = document 'body_texts.txt'
  end

  def generic_post
    current = "None"
    post = ""
    next_word = sample_word(@probability_hash[current])
    until post.size > 410 && next_word == nil
      if next_word == nil
        next_word = sample_word(@probability_hash["None"])
      else
        if next_word.match(/[\,\.\;\:\-\!\?]/)
          post << next_word
        else
          post << " #{next_word}"
        end
        current = next_word
        next_word = sample_word(@probability_hash[current])
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
    @probability = {}
    counted_bigrams.each do |key, count_hash|
      count_hash.each do |inner_key, value|
        @probability[key] ||= {}
        #set probability of each word by diving it's count by the count of all words in that hash
        @probability[key][inner_key] = (value.to_f / counted_bigrams[key].values.inject(0){|a,b| a + b}.to_f)
      end
    end
    @probability
  end
  
  def count_bigrams(tokenized_stories)
    @count = {}
    tokenized_stories.each do |sent|
      sent = ["None"] + sent 
      # creates the bigrams by zipping the sentenece together w/ subset of sentence
      sent.zip(sent[1..-1]).each do |current, on_deck|
        @count[current] ||= {}
        @count[current][on_deck] ||= 0
        @count[current][on_deck] += 1
      end
    end
    @count
  end

  def tokenize
    @story.apply(:chunk, :segment, :tokenize, :category)
    @tokenized_sentences = []
    @story.sentences.each do |sent|
      @tokenized_sentences << sent.to_a
    end
    @tokenized_sentences
  end

  def find_word_popularity
    word_frequency = {}
    @story.apply(:chunk, :segment, :tokenize, :category)
    unique_words = @story.words.map {|word| word.to_s.downcase}.uniq
    unique_words.each do |w|
      words[w] = @story.frequency_of(w)
    end
    word_frequency 
  end

  def find_adjective_popularity(word_frequency_hash)
    word_frequency_hash.select do |key, value|
      key.category == 'adjective'
    end
  end

end


