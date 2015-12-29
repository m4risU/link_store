require 'nokogiri'
require 'open-uri'

class Site < ActiveRecord::Base
  validates :url, presence: true
  validates :source, presence: true

  attr_accessor :search

  scope :search, -> (filter) {
    downcased_filter = filter.to_s.downcase
    where(
      "LOWER(description) LIKE ? OR LOWER(source) LIKE ? OR LOWER(url) LIKE ?",
      "%#{downcased_filter}%", "%#{downcased_filter}%", "%#{downcased_filter}%"
    )
  }

  def fetch_stats
    doc = Nokogiri::HTML(open(source))
    doc.css('#contact-panel-content > div:nth-child(3) > span.span8 > p.color-s3').each do |desc|
      update_attributes(description: desc.content)
    end
  end
end
