require 'singleton' # We'll only need ONE search class

class Search
  include Singleton

  DEFAULT_ENGINE = 1 # google

  attr_accessor :engines, :query, :offset #our class attributes

  def initialize(engines=[DEFAULT_ENGINE], query="", offset=0)
    @engines = engines
    @query = URI.encode(query)
    @offset = offset
  end

  def search
    "Searching with:\n #{self.inspect}"
  end

end
