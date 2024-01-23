# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
# Downloads contents of URL
class UrlParserService
  def initialize(url)
    @url = url
  end

  def fetch_head
    html = URI.open(@url).read
    doc = Nokogiri::HTML(html)

    title = doc.at_css('title')&.text
    favicon = find_favicon(doc)

    { title:, favicon: }
  end

  private

  def find_favicon(doc)
    favicon_tag = doc.at_css('link[rel="icon"]') || doc.at_css('link[rel="shortcut icon"]')

    return nil unless favicon_tag

    favicon_url = favicon_tag.attribute('href')&.value

    # Convert relative URL to absolute URL
    favicon_url = URI.join(@url, favicon_url).to_s if favicon_url && !favicon_url.start_with?('http')

    favicon_url
  end
end
