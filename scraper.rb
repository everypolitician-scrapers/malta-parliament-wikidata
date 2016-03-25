#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_parliament_of_Malta,_2013%E2%80%93',
  xpath: '//h2[span[contains(.,"List of MPs")]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title',
) 

EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })
