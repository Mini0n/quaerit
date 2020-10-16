class SearchController < ApplicationController
  before_action :set_search, only: [:search]

  def search
    puts '-' * 43
    puts params.inspect
    puts '-' * 43
    puts @search.inspect
    puts '-' * 43

    render json: {'ola': 'k ase?'}
  end

  def about
    render plain: "Quearit\n\nSearch endpoint at: /search\n\nMore info in repo:\nhttps://github.com/Mini0n/quaerit"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.instance
    end

    # Only allow a trusted parameter "white list" through.
    def search_params
      params.permit(:engines, :query, :offset)
    end
end
