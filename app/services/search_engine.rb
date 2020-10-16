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
end
