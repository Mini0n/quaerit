# frozen_string_literal: true

class BingSearchEngine < SearchEngine
  ENGINE_NAME = 'Bing'
  BASE_URL = 'https://www.bing.com/search?'
  CHROME_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'

  def initialize(params)
    @query = params[:query]
    @offset = params[:offset]
  end

  def search
    response = self.class.get("#{BASE_URL}q=#{@query}&first=#{@offset}", headers: { 'User-Agent' => CHROME_AGENT })
    html_res = Nokogiri::HTML(response.body)

    parse_body(html_res)
  rescue StandardError => e
    search_error(e)
  end

  def self.name # Class method to get the engine name
    ENGINE_NAME
  end

  private

  def parse_body(html_res)
    results = html_res.search('#b_results').first.children[0, 10] # 10 results

    results.map { |result| parse_result(result) }
  end

  def parse_result(result)
    {
      title: result.children.first.text,
      link: result.children.last.children.first.text,
      summary: result.children.last.children.last.text
    }
  end

  def search_error(error)
    { 'error': 'An error ocurred through the search process',
      'details': error }
  end
end
