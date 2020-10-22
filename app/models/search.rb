# frozen_string_literal: true

class Search
  DEFAULT_ENGINE = 1 # google
  ENGINES = { # new engines can be easily added here
    1 => GoogleSearchEngine,
    2 => BingSearchEngine
  }.freeze

  attr_accessor :engines, :query, :offset # our class attributes

  def initialize(engines: [DEFAULT_ENGINE], query: '', offset: 0)
    @engines = engines
    @offset = offset
    @query = query
  end

  def search
    return params_error if invalid_search? # check search will be valid

    params = { query: @query, offset: @offset }
    results = []

    @engines.each do |engine|
      results << (ENGINES.key?(engine) ?
                  engine_results(engine, search_with_engine(engine, params)) :
                  engine_error(engine))
    end

    {
      search: params.merge({ engines: @engines.to_s }),
      results: results
    }
  end

  def search_with_engine(engine, params)
    ENGINES[engine].new(params).search
  rescue StandardError => e
    [search_error(e.message)]
  end

  # === SETTERS === === === === === === === === === === === === === === === ===

  # parse engines
  def engines=(engines_param)
    @engines = extract_integers(engines_param)
    @engines = [DEFAULT_ENGINE] if @engines.empty? # use default engine if none
  end

  # parse query
  def query=(query_param)
    @query = CGI.escape(query_param)
  end

  # parse offset
  def offset=(offset_param)
    @offset = extract_integers(offset_param).first || 0
  end

  private

  def extract_integers(param)
    param.to_s.scan(/\d+/).map(&:to_i)
  end

  def invalid_search?
    @engines.empty? || @query.empty?
  end

  def engine_results(engine, results)
    { engine: ENGINES[engine].name, results: results }
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
