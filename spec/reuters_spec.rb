require './lib/buzzwords/reuters.rb'

describe 'Reuters' do
  context '#headlines' do
    it 'returns a non-empty array' do
      headlines = Reuters.new.headlines
      expect(headlines).not_to be_empty
      expect(headlines).to be_an_instance_of(Array)
    end
  end
end
