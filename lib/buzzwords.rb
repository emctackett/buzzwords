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
    display_loading
    retrieve_nytimes_headlines
    retrieve_wapo_headlines
    retrieve_cnn_headlines
    filter_stopwords
    count_word_occurrences
    determine_top_words
    display_top_words
  end

  private

  def display_loading
    puts "Loading current buzzwords..."
  end

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

  def determine_top_words
    self.top_words = word_occurrences.sort_by { |k, v| v }.reverse.take(20)
                    .reject{ |word| word.last < 3 }
                    .map { |word| word.first }
  end

  def display_top_words
    puts "Today's top buzzwords are: "
    top_words.each { |word| puts " - #{word}" }
  end
end

buzzwords = Buzzwords.new

