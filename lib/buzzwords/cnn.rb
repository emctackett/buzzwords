class CNN
  attr_reader :webpage, :headlines

  CNN_US_HEADLINES_URL = "https://www.cnn.com/us"

  def initialize
    @webpage = Buzzwords::MECH.get(CNN_US_HEADLINES_URL)
  end

  def headlines
    webpage.search('.cd__headline-text').map do |headline|
      headline.text.downcase.strip
    end.slice(0, 25)
  end
end
