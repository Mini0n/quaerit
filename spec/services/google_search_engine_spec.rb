# frozen_string_literal: true

require 'rails_helper'
require './spec/services/search_engine_spec.rb'

RSpec.describe GoogleSearchEngine do
  it_behaves_like 'a SearchEngine'
end
