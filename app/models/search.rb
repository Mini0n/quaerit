# frozen_string_literal: true

class Search
  DEFAULT_ENGINE = 1 # google
  ENGINES = { # new engines can be easily added here
    1 => GoogleSearch,
    2 => BingSearch
  }.freeze

  attr_accessor :engines, :query, :offset # our class attributes

  def initialize(engines = [DEFAULT_ENGINE], query = '', offset = 0)
    @engines = engines
    @query = URI.encode(query)
    @offset = offset
  end

  def search
    puts "Searching with:\n #{inspect}"
    puts '-- Searching'

    return params_error unless valid_search? # check search will be valid

    params = { query: @query, offset: @offset, engines: @engines.to_s }
    results = []

    @engines.each do |engine|
      results << case engine
                 when 1
                   search_google(params)
                 when 2
                   search_bing(params)
                 else
                   engine_error(engine)
      end
    end

    {
      search: params,
      results: results
    }
  end

  def search_google(_params)
    engine_results(1,
                   [{ "title": 'cosa', "url": 'algo', "summary": 'stuff stuff' }])
  end

  def search_bing(_params)
    engine_results(2,
                   [{ "title": 'cosa', "url": 'algo', "summary": 'stuff stuff' }])
  end

  # parse engines
  def engines=(engines)
    @engines = engines.scan(/\d+/).map(&:to_i)
    @engines = [DEFAULT_ENGINE] if @engines.empty? # use default engine if none
  end

  # parse offset
  def offset=(offset)
    @offset = offset.scan(/\d+/).map(&:to_i).first || 0
  end

  private

  def valid_search?
    return false if @engines.empty? || @query.empty?

    true
  end

  def engine_results(engine, results)
    { engine: "#{ENGINES[engine]} [#{engine}]", results: results }
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
