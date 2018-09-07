require 'mechanize'

require_relative 'ny_times.rb'
require_relative 'washington_post.rb'
require_relative 'cnn.rb'
require_relative 'stopwords.rb'

class Buzzwords
  include Stopwords

  attr_reader :nytimes, :wapo, :cnn
  attr_accessor :aggregate_headlines, :word_occurrences, :top_words

  MECH = Mechanize.new

  def initialize
    @nytimes = NYTimes.new
    @wapo = WashingtonPost.new
    @cnn = CNN.new
    @aggregate_headlines = []
    @word_occurrences = {}
    @top_words = nil
    generate_buzz
  end

  def generate_buzz
    retrieve_nytimes_headlines
    retrieve_wapo_headlines
    retrieve_cnn_headlines
    filter_stopwords
    count_word_occurrences
    sort_word_occurrences
  end

  private

  def retrieve_nytimes_headlines
    self.aggregate_headlines += parse_headlines(nytimes.headlines)
  end

  def retrieve_wapo_headlines
    self.aggregate_headlines += parse_headlines(wapo.headlines)
  end

  def retrieve_cnn_headlines
    self.aggregate_headlines += parse_headlines(cnn.headlines)
  end

  def parse_headlines(data)
    data.map(&:split).flatten.map do |word|
      word.delete('/\A[\W]/').delete('/[\W]\z/').gsub(/\'s/, '')
    end
  end

  def filter_stopwords
    self.aggregate_headlines = aggregate_headlines.select do |word|
      Stopwords.valid?(word)
    end
  end

  def count_word_occurrences
    aggregate_headlines.each do |word|
      word_occurrences[word] ? word_occurrences[word] += 1 : word_occurrences[word] = 1
    end
  end

  def sort_word_occurrences # this method is not working
    # self.top_words = word_occurrences.keys.sort_by do |key1, key2|
    #   word_occurrences[key2] <=> word_occurrences[key1]
    # end
  end
end

buzzwords = Buzzwords.new

p buzzwords.top_words
