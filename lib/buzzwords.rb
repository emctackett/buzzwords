require 'mechanize'

require_relative 'buzzwords/ny_times.rb'
require_relative 'buzzwords/washington_post.rb'
require_relative 'buzzwords/cnn.rb'
require_relative 'buzzwords/reuters.rb'
require_relative 'buzzwords/stopwords.rb'

class Buzzwords
  MECH = Mechanize.new

  @aggregate_headlines = []
  @word_occurrences = Hash.new(0)
  @top_words = nil

  class << self
    attr_accessor :aggregate_headlines, :word_occurrences, :top_words
  end

  def self.generate_buzz
    display_loading
    retrieve_nytimes_headlines
    retrieve_wapo_headlines
    retrieve_cnn_headlines
    retrieve_reuters_headlines
    filter_stopwords
    count_word_occurrences
    determine_top_words
    display_top_words
  end

  def self.display_loading
    puts "Loading current buzzwords..."
  end

  def self.retrieve_nytimes_headlines
    self.aggregate_headlines += parse_headlines(NYTimes.new.headlines)
  end

  def self.retrieve_wapo_headlines
    self.aggregate_headlines += parse_headlines(WashingtonPost.new.headlines)
  end

  def self.retrieve_cnn_headlines
    self.aggregate_headlines += parse_headlines(CNN.new.headlines)
  end

  def self.retrieve_reuters_headlines
    self.aggregate_headlines += parse_headlines(Reuters.new.headlines)
  end

  def self.parse_headlines(data)
    data.map(&:split).flatten.map do |word|
      word.delete('/\A[\W]/').delete('/[\W]\z/').gsub(/\'s/, '')
    end
  end

  def self.filter_stopwords
    self.aggregate_headlines = aggregate_headlines.select do |word|
      Stopwords.valid?(word)
    end
  end

  def self.count_word_occurrences
    aggregate_headlines.each do |word|
      word_occurrences[word] += 1
    end
  end

  def self.determine_top_words
    self.top_words = word_occurrences.sort_by { |k, v| v }.reverse.take(20)
                    .reject{ |word| word.last < 3 }
                    .map { |word| word.first }
  end

  def self.display_top_words
    puts "Today's top buzzwords are: "
    top_words.each { |word| puts " - #{word}" }
  end
end
