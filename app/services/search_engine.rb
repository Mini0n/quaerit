# frozen_string_literal: true

# === === === === === === === === === === === === === === === === === === ===
# SearchEngine Interface
# === === === === === === === === === === === === === === === === === === ===

class SearchEngine
  include HTTParty

  def search
    { "error": 'Engine search not implemented' }
  end

  def self.name
    'SearchEngine'
  end

  def search_error(error)
    { 'error': 'An error ocurred through the search process',
      'details': error }
  end

  def valid_url?(url)
    uri = URI.parse(URI.escape(url))
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue StandardError
    false
  end
end
