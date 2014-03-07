#!/usr/bin/env ruby

require 'scraperwiki'
require 'nokogiri'

html = ScraperWiki.scrape('http://www.nyam.org/library/search-collections/archives/')

doc = Nokogiri::HTML(html)

doc.search("div[@id='contentDiv'] ul li").each do |litem|

    full_link = litem.search("a/@href").first.value
    file_n = full_link[-12, 12]
    text = litem.search("a").text
    
    data = {'url' => full_link, 'file' => file_n, 'title' => text}
    
    ScraperWiki.save_sql(['file'], data)
end



# Saving data:
# unique_keys = [ 'id' ]
# data = { 'id'=>12, 'name'=>'violet', 'age'=> 7 }
# ScraperWiki.save_sqlite(unique_keys, data)



