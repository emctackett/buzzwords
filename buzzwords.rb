require 'mechanize'

require_relative 'ny_times.rb'

class Buzzwords
  attr_reader :nytimes
  attr_accessor :aggregate_headlines

  MECH = Mechanize.new

  def initialize
    @nytimes = NYTimes.new
    @aggregate_headlines = []
    generate_buzz
  end

  private

  def retrieve_nytimes_headlines
    self.aggregate_headlines += nytimes.headlines
  end

  def generate_buzz
    retrieve_nytimes_headlines
  end
end

buzzwords = Buzzwords.new
p buzzwords.aggregate_headlines
