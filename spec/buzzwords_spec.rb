require 'buzzwords'

describe 'buzzwords' do
  context '#display_loading' do
    it 'displays load message' do
      expect { Buzzwords.display_loading }.to output(/Loading current buzzwords...\n/).to_stdout
    end
  end
end
