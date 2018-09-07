require 'mechanize'

require_relative 'ny_times.rb'
require_relative 'stopwords.rb'

class Buzzwords
  include Stopwords

  attr_reader :nytimes
  attr_accessor :aggregate_headlines

  MECH = Mechanize.new

  def initialize
    @nytimes = NYTimes.new
    @aggregate_headlines = []
    generate_buzz
  end

  def generate_buzz
    retrieve_nytimes_headlines
    p aggregate_headlines.length
    filter_stopwords
    p aggregate_headlines.length
  end

  private

  def retrieve_nytimes_headlines
    self.aggregate_headlines += nytimes.headlines.map(&:split).flatten.map do |word|
      word.delete('/\A[\W]/').delete('/[\W]\z/').gsub(/\'s/, '')
    end
  end

  def filter_stopwords
    self.aggregate_headlines = aggregate_headlines.select do |word|
      Stopwords.valid?(word)
    end
  end
end

buzzwords = Buzzwords.new
p buzzwords.aggregate_headlines
