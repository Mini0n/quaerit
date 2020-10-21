# frozen_string_literal: true

require 'rails_helper'
require './spec/services/search_engine_spec.rb'

RSpec.describe GoogleSearchEngine do
  subject { GoogleSearchEngine.new(query: 'test', offset: 0) }
  it_should_behave_like 'a SearchEngine'
end
