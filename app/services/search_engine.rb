# frozen_string_literal: true

# === === === === === === === === === === === === === === === === === === ===
# SearchEngine Interface
# === === === === === === === === === === === === === === === === === === ===

class SearchEngine
  include HTTParty

  def initialize(params)
    @query = params[:query]
    @offset = params[:offset]
  end

  def search
    [{ "error": 'Engine search not implemented' }]
  end

  def self.name
    to_s
  end

  def search_error(error)
    { error: 'An error ocurred through the search process',
      detail: error,
      caller: caller_locations(1, 1)[0].label }
  end

  def valid_url?(url)
    return false if url.empty?

    uri = URI.parse(url)

    return false if uri.host.nil?

    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue StandardError
    false
  end
end
