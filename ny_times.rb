class NYTimes
  attr_reader :test, :webpage, :headlines

  US_HEADLINE_URL = "https://www.nytimes.com/section/us"

  def initialize
    @test = 'test'
    @webpage = Buzzwords::MECH.get(US_HEADLINE_URL)
  end

  def headlines
    webpage.search('.initial-set .headline').map do |headline|
      headline.text.strip
    end
  end
end
