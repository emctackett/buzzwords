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

  context '.parse_headlines' do
    before(:all) { @headlines = Buzzwords.parse_headlines(NYTimes.new.headlines) }

    it 'should return an array' do
      expect(@headlines).to be_an_instance_of(Array)
    end

    it 'should only include properly formatted words' do
      @headlines.each do |headline|
        expect(headline).not_to include('/(\A[\W]||[\W]\z)/')
        expect(headline).not_to include('/\'s/')
      end
    end
  end

  context '.filter_stopwords' do
    before { Buzzwords.retrieve_nytimes_headlines }

    it 'should filter stopwords from aggregate headline list' do
      Buzzwords.filter_stopwords
      expect(Buzzwords.aggregate_headlines).not_to include(*Stopwords::STOP_WORDS)
    end
  end

  context '.count_word_occurrences' do
    before(:all) do
      Buzzwords.retrieve_cnn_headlines
      Buzzwords.count_word_occurrences
    end

    it 'should return a hash' do
      expect(Buzzwords.word_occurrences).to be_an_instance_of(Hash)
      expect(Buzzwords.word_occurrences).not_to be_empty
    end

    it 'should have integer values in the hash' do
      expect(Buzzwords.word_occurrences.values).to all(be_an(Integer))
    end
  end
end
