# frozen_string_literal: true

class Search
  DEFAULT_ENGINE = 1 # google

  attr_accessor :engines, :query, :offset # our class attributes

  def initialize(engines = [DEFAULT_ENGINE], query = '', offset = 0)
    @engines = engines
    @query = URI.encode(query)
    @offset = offset
  end

  def search
    "Searching with:\n #{inspect}"
  end

  # parse engines
  def engines=(engines)
    @engines = engines.scan(/\d+/).map(&:to_i)
  end
end
