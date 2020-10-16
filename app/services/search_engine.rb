# frozen_string_literal: true

# === === === === === === === === === === === === === === === === === === ===
# SearchEngine Interface
# === === === === === === === === === === === === === === === === === === ===

class SearchEngine
  def search
    { "error": 'Engine search not implemented' }
  end

  def self.name
    'ISearchEngine'
  end
end
