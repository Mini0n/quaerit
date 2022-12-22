# frozen_string_literal: true

class GoogleSearchEngine < SearchEngine
  BASE_URL = 'https://www.google.com/search?'

  def search
    response = self.class.get("#{BASE_URL}q=#{@query}&start=#{@offset}")
    html_res = Nokogiri::HTML(response.body)

    parse_body(html_res)
  rescue StandardError => e
    search_error(e.message)
  end

  private

  def parse_body(html_res)
    results = html_res.css("div#main>div").select{ |el| el.css("h3").count == 1 }

    results.each.with_object([]) do |result, array|
      parsed = parse_result(result)
      array << parsed unless parsed.empty?
    end
  rescue StandardError => e
    [search_error(e.message)]
  end

  def parse_result(result)
    link = result.css('a')
    decoded = link.first['href'][7..-1]
    decoded = decoded[0...decoded.index('&sa=')] # get result link

    return {} unless valid_url?(decoded)

    {
      title: link.text,
      link: decoded,
      summary: result.children.first.children.last.content
    }
  rescue StandardError => e
    search_error(e.message)
  end
end
