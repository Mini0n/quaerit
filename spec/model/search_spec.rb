# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search do
  describe '#search' do
    it 'executes a search' do
      params = { engines: [1], query: 'search term', offset: 0 }
      search = described_class.new(**params)
      engine = GoogleSearchEngine.new(params)
      result = ['results']

      expect(GoogleSearchEngine).to receive(:new) { engine }
      expect(engine).to receive(:search) { result }

      results = search.search

      expect(results[:search][:query]).to eq params[:query]
      expect(results[:results].first[:engine]).to include(GoogleSearchEngine.name)
      expect(results[:results].first[:results]).to eq result
    end
  end

  describe '#search_with_engine' do
    it 'performs a search with the selected Search Engine' do
      params = { query: 'search tearm', offset: 0 }
      engine = GoogleSearchEngine.new(params)
      result = ['results']

      expect(GoogleSearchEngine).to receive(:new).with(params) { engine }
      expect(engine).to receive(:search) { ['results'] }

      results = subject.search_with_engine(1, params)

      expect(results).to eq result
    end
  end

  describe '#engines=' do
    it 'assigns a valid @engines array' do
      subject.engines = '1,2'
      expect(subject.engines).to eq [1, 2]

      subject.engines = ''
      expect(subject.engines).to eq [described_class::DEFAULT_ENGINE]

      subject.engines = 'a,b,c'
      expect(subject.engines).to eq [described_class::DEFAULT_ENGINE]

      subject.engines = 'a,b,c,1,4'
      expect(subject.engines).to eq [1, 4]
    end
  end

  describe '#query=' do
    it 'assigns an URI escaped query to @query' do
      subject.query = 'search term'
      expect(subject.query).to eq 'search+term'

      subject.query = 'something_more=exotic-'
      expect(subject.query).to eq 'something_more%3Dexotic-'

      subject.query = '/S3P - Я живу мечтой'
      expect(subject.query).to eq '%2FS3P+-+%D0%AF+%D0%B6%D0%B8%D0%B2%D1%83+%D0%BC%D0%B5%D1%87%D1%82%D0%BE%D0%B9'
    end
  end

  describe '#offset=' do
    it 'assigns a valid offset to @offset' do
      subject.offset = 1
      expect(subject.offset).to eq 1

      subject.offset = '1'
      expect(subject.offset).to eq 1

      subject.offset = 'a'
      expect(subject.offset).to eq 0

      subject.offset = '1893'
      expect(subject.offset).to eq 1893

      subject.offset = '145.45'
      expect(subject.offset).to eq 145

      subject.offset = ''
      expect(subject.offset).to eq 0

      subject.offset = nil
      expect(subject.offset).to eq 0
    end
  end

  describe '#engine_results' do
    it 'returns a hash with results' do
      results = ['results']
      result = subject.send(:engine_results, 1, results)

      expect(result[:engine]).to include(GoogleSearchEngine.name)
      expect(result[:results]).to eq results
    end
  end

  describe '#invalid_search?' do
    context 'invalid search: empty search or engines array' do
      it 'returns true' do
        expect(subject.send(:invalid_search?)).to eq true
      end
    end

    context 'valid search: not empty search or engines array' do
      it 'returns false' do
        subject.query = 'search term'

        expect(subject.send(:invalid_search?)).to eq false
      end
    end
  end

  describe '#engine_error' do
    it 'returns an engine search error hash' do
      result = subject.send(:engine_error, -1)

      expect(result.keys.first).to match(:error)
      expect(result.values.first).to include('No engine for code')
    end
  end

  describe '#params_error' do
    it 'returns a params search error hash' do
      result = subject.send(:params_error)

      expect(result.keys.first).to match(:error)
      expect(result.values.first).to include('(Invalid || Empty) params')
    end
  end

  describe '#search_error' do
    it 'returns a search error hash' do
      error = 'test_description'
      result = subject.send(:search_error, error)

      expect(result.keys.first).to match(:error)
      expect(result.values.first).to match(error)
    end
  end
end
