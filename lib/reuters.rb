class Reuters
  attr_reader :webpage, :headlines

  US_HEADLINE_URL = "https://www.reuters.com/news/us"

  def initialize
    @webpage = Buzzwords::MECH.get(US_HEADLINE_URL)
  end

  def headlines
    webpage.search('.FeedItemHeadline_full a').map do |headline|
      headline.text.downcase.strip
    end
  end
end
