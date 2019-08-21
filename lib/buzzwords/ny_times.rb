class NYTimes
  attr_reader :webpage, :headlines

  US_HEADLINE_URL = "https://www.nytimes.com/section/us"

  def initialize
    @webpage = Buzzwords::MECH.get(US_HEADLINE_URL)
  end

  def headlines
    webpage.search('.css-1j9dxys').map do |headline|
      headline.text.downcase.strip
    end
  end
end
