# frozen_string_literal: true

class GoogleSearchEngine < SearchEngine
  ENGINE_NAME = 'Google'
  BASE_URL = 'https://www.google.com/search?'

  def initialize(params)
    @query = params[:query]
    @offset = params[:offset]
  end

  def search
    response = self.class.get("#{BASE_URL}q=#{@query}&start=#{@offset}")
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
    results = html_res.search('#main').children.slice(3, 10) # 10 results
    results = results.map { |result| result.children.first.children } # traverse results

    results.map { |result| parse_result(result) } # return an array of parsed results
  end

  def parse_result(result)
    link = result.first.search('a')
    decoded = URI.decode(link.first['href'][7..-1])

    {
      title: link.text,
      link: decoded[0...decoded.index('&sa=')],
      summary: result.children[1..-1].text
    }
  end

  def search_error(error)
    { 'error': 'An error ocurred through the search process',
      'details': error }
  end
end
