require 'buzzwords'

describe 'buzzwords' do
  context '.display_loading' do
    it 'displays load message' do
      expect { Buzzwords.display_loading }.to output(/Loading current buzzwords...\n/).to_stdout
    end
  end

  context 'retrieve headlines' do
    before(:each) { Buzzwords.aggregate_headlines = [] }

    context '.retrieve_nytimes_headlines' do
      it 'adds NYT headlines to aggregate' do
        Buzzwords.retrieve_nytimes_headlines
        expect(Buzzwords.aggregate_headlines).not_to be_empty
      end
    end

    context '.retrieve_wapo_headlines' do
      it 'adds Wapo headlines to aggregate' do
        Buzzwords.retrieve_wapo_headlines
        expect(Buzzwords.aggregate_headlines).not_to be_empty
      end
    end
    context '.retrieve_cnn_headlines' do
      it 'adds CNN headlines to aggregate' do
        Buzzwords.retrieve_cnn_headlines
        expect(Buzzwords.aggregate_headlines).not_to be_empty
      end
    end
    context '.retrieve_reuters_headlines' do
      it 'adds Reuters headlines to aggregate' do
        Buzzwords.retrieve_reuters_headlines
        expect(Buzzwords.aggregate_headlines).not_to be_empty
      end
    end
  end
end
