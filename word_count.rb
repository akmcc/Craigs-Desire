class WordCount

  def initialize(phrase)
    @phrase = phrase
    @words_to_ignore = ["he", "she", "i", "you", "we", "they", "them", "our", "my", "your", "his", "her", "their", "it", "it's", "to", "from", "on", "in", "and", "this", "that", "is", "was", "will", "be", "being", "been", "has", "of", "i'm", "i'd", "i've", "any", "well", "or", "but", "an", "a", "the", "do", "for", "with", "if", "have", "were", "not", "at", "so", "are", "what", "as", "for", "me", "out", "in", "know", "would", "had", "all", "up", "down", "do", "don't", "there", "here"]
  end

  def word_count
    word_counts = {}
    split_into_words(@phrase).each do |word|
      unless @words_to_ignore.include?(word.downcase)
        increment_word_count(word_counts, word)
      end
    end
    word_counts
  end

  private

  def increment_word_count(word_counts, word)
    word.downcase!
    if word_counts[word]
      word_counts[word] += 1
    else
      word_counts[word] = 1
    end
  end

  def split_into_words(phrase)
    phrase.scan(/[a-zA-Z0-9\']+/)
  end

end