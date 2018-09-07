require_relative 'ny_times.rb'

class Buzzwords
  attr_reader :nytimes

  def initialize
    @nytimes = NYTimes.new
  end
end

buzzwords = Buzzwords.new
p buzzwords.nytimes.test
