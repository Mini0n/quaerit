# frozen_string_literal: true

class Search
  DEFAULT_ENGINE = 1 # google
  ENGINES = { # new engines can be easily added here
    1 => GoogleSearchEngine,
    2 => BingSearchEngine
  }.freeze

  attr_accessor :engines, :query, :offset # our class attributes

  def initialize(engines = [DEFAULT_ENGINE], query = '', offset = 0)
    @engines = engines
    @query = query
    @offset = offset
  end

  def search
    return params_error if invalid_search? # check search will be valid

    params = { query: @query, offset: @offset }
    results = []

    @engines.each do |engine|
      results << (ENGINES.key?(engine) ?
                  engine_results(engine, search_with_engine(engine, params)) : engine_error(engine))
    end

    {
      search: params.merge({ engines: @engines.to_s }),
      results: results
    }
  end

  def search_with_engine(engine, params)
    engine = ENGINES[engine].new(params)

    engine.search
  end

  # === SETTERS === === === === === === === === === === === === === === === ===

  # parse engines
  def engines=(engines)
    @engines = engines.scan(/\d+/).map(&:to_i)
    @engines = [DEFAULT_ENGINE] if @engines.empty? # use default engine if none
  end

  # parse query
  def query=(query)
    @query = URI.encode(query)
  end

  # parse offset
  def offset=(offset)
    @offset = offset.scan(/\d+/).map(&:to_i).first || 0
  end

  private

  def invalid_search?
    @engines.empty? || @query.empty?
  end

  def engine_results(engine, results)
    { engine: "#{ENGINES[engine].name} [#{engine}]", results: results }
  end

  def engine_error(engine)
    search_error("No engine for code #{engine}")
  end

  def params_error
    search_error("(Invalid || Empty) params: [engines:#{@engines}, query:#{@query}]")
  end

  def search_error(description)
    { error: description }
  end
end
