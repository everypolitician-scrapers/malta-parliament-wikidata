#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri'
require 'rest-client'

def noko_for(url)
  Nokogiri::HTML(open(url).read) 
end

def wikinames(url)
  noko = noko_for(url)
  noko.xpath('//h2[span[contains(.,"List of MPs")]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title').map(&:text)
end

names = wikinames('https://en.wikipedia.org/wiki/List_of_members_of_the_parliament_of_Malta,_2013%E2%80%93')

WikiData.ids_from_pages('en', names).each_with_index do |p, i|
  data = WikiData::Fetcher.new(id: p.last).data('fr') rescue nil
  unless data
    warn "No data for #{p}"
    next
  end
  ScraperWiki.save_sqlite([:id], data)
end
warn RestClient.post ENV['MORPH_REBUILDER_URL'], {} if ENV['MORPH_REBUILDER_URL']

