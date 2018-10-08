class WashingtonPost
  attr_reader :webpage, :headlines

  WAPO_URL = "https://www.washingtonpost.com"

  def initialize
    @webpage = Buzzwords::MECH.get(WAPO_URL)
  end

  def headlines
    webpage.search('#main-content .headline a').map do |headline|
      headline.text.downcase.strip
    end
  end
end
