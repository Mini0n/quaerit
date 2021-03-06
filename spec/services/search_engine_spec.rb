# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'SearchEngine shared context' do
  let(:test_params_valid) { { query: 'ringo deathstarr', offset: 0 } }
end

RSpec.shared_examples 'a SearchEngine' do
  include_context 'SearchEngine shared context'

  subject { described_class.new(test_params_valid) }

  it 'respondes to default methods' do
    expect(described_class).to respond_to(:new).with(1).argument
    expect(described_class).to respond_to(:name).with(0).arguments

    expect(subject).to respond_to(:search).with(0).arguments
    expect(subject).to respond_to(:search_error).with(1).argument
    expect(subject).to respond_to(:valid_url?).with(1).argument
  end

  describe '#search' do
    it 'it returns a Hash' do
      expect(subject.search.class).to eq Array
    end
  end

  describe '#search_error' do
    it 'it returns an error Hash' do
      error = 'test error'
      result = subject.search_error(error)

      expect(result.class).to be Hash
      expect(result.keys).to eq %i[error detail caller]
      expect(result[:detail]).to eq error
    end
  end
end

RSpec.describe SearchEngine do
  it_behaves_like 'a SearchEngine'
  include_context 'SearchEngine shared context'

  subject { described_class.new(test_params_valid) }

  describe '#valid_url?' do
    it 'checks if an URL is valid' do
      expect(subject.valid_url?('http://example.com')).to be true
      expect(subject.valid_url?('https://www.example.com')).to be true
      expect(subject.valid_url?('http://example.com/sample?q=search')).to be true
      expect(subject.valid_url?('https://example.com/sample?q=search&term=1,2')).to be true

      expect(subject.valid_url?('example.com')).to be false
      expect(subject.valid_url?('emailto:test@mail.com')).to be false
      expect(subject.valid_url?('https://')).to be false
      expect(subject.valid_url?('')).to be false
    end
  end
end
