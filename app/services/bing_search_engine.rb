# frozen_string_literal: true

class BingSearchEngine < SearchEngine
  BASE_URL = 'https://www.bing.com/search?'
  CHROME_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'

  def search
    response = self.class.get("#{BASE_URL}q=#{@query}&first=#{@offset}", headers: { 'User-Agent' => CHROME_AGENT })
    html_res = Nokogiri::HTML(response.body)

    parse_body(html_res)
  rescue StandardError => e
    search_error(e.message)
  end

  private

  def parse_body(html_res)
    results = html_res.search('#b_results').first.children[0, 10] # 10 results

    results.each.with_object([]) do |result, array|
      parsed = parse_result(result)
      array << parsed unless parsed.empty?
    end
  rescue StandardError => e
    [search_error(e.message)]
  end

  def parse_result(result)
    decoded = result.children.last.children.first.text

    return {} unless valid_url?(decoded)

    {
      title: result.children.first.text,
      link: decoded,
      summary: result.children.last.children.last.text
    }
  rescue StandardError => e
    search_error(e.message)
  end
end
