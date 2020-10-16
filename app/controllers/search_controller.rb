# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :set_search, only: [:search]

  def search
    results = @search.search

    render json: results
  end

  def about
    title = '<h2>Quaerit</h2>'
    route = '- Search at: <a href="/search?query=kabuto&offset=10&engines=1,2">/search</a>'
    github = '- More info at: <a href="http://github.com/Mini0n/quaerit" target="_blank">Quaerit repo</a>'

    render html: "<pre>#{title}#{route}\n\n#{github}</pre>".html_safe
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # get the Search singleton instance and set its attributes from search_params
  def set_search
    @search = Search.new
    search_params.to_h.each { |param, value| @search.send("#{param}=", value) }
  end

  # Only allow a trusted parameter "white list" through.
  def search_params
    params.permit(:engines, :query, :offset)
  end
end
