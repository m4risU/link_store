require 'nokogiri'
require 'open-uri'

class Site < ActiveRecord::Base
  def fetch_stats
    doc = Nokogiri::HTML(open(source))

    doc.css('#contact-panel-content > div:nth-child(3) > span.span8 > p.color-s3').each do |desc|
      update_attributes(description: desc.content)
    end
  end
end
