require 'cnn'

describe 'cnn' do
  context '#headlines' do
    it 'returns a non-empty array' do
      headlines = CNN.new.headlines
      expect(headlines).not_to be_empty
      expect(headlines).to be_an_instance_of(Array)
    end
  end
end
