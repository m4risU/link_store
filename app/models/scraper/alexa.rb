require 'nokogiri'
require 'open-uri'

class Scraper::Alexa
  class << self
    def run
      (0..3).to_a.each do |page|
        doc = Nokogiri::HTML(open("http://www.alexa.com/topsites/global;#{page}"))

        doc.css('div.listings > ul .desc-paragraph a').each do |link|
          site = Site.find_or_create_by(url: link.content.strip)
          site.update_attributes(source: "http://www.alexa.com#{link['href']}")
          # best to delay it
          site.fetch_stats
        end
      end
    end
  end
end
