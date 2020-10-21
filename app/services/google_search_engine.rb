# frozen_string_literal: true

class GoogleSearchEngine < SearchEngine
  BASE_URL = 'https://www.google.com/search?'

  def search
    response = self.class.get("#{BASE_URL}q=#{@query}&start=#{@offset}")
    html_res = Nokogiri::HTML(response.body)

    parse_body(html_res)
  rescue StandardError => e
    search_error(e)
  end

  private

  def parse_body(html_res)
    results = html_res.search('#main').children.slice(3, 10) # 10 results
    results = results.map { |result| result.children.first.children } # traverse results

    results.each.with_object([]) do |result, array|
      parsed = parse_result(result)
      array << parsed unless parsed.empty?
    end
  end

  def parse_result(result)
    link = result.first.search('a')
    decoded = URI.decode(link.first['href'][7..-1])
    decoded = decoded[0...decoded.index('&sa=')] # get result link

    return {} unless valid_url?(decoded)

    {
      title: link.text,
      link: decoded,
      summary: result.children[1..-1].text
    }
  rescue StandardError
    {}
  end
end
