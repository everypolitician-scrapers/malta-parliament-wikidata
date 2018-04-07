#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_parliament_of_Malta,_2013%E2%80%93',
  xpath: '//h2[span[contains(.,"List of MPs")]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title',
)
mt = WikiData::Category.new( 'Kategorija:Politiċi Maltin', 'mt').member_titles

query = 'SELECT DISTINCT ?item WHERE { ?item p:P39/ps:P39 wd:Q37857097 }'
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { en: en, mt: mt })
