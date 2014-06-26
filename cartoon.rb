# -*- coding: utf-8 -*-
require "open-uri"
require "rubygems"
require "nokogiri"
require "carrier-pigeon"

uri = (Time.now.utc).strftime("http://www.xnxx.com/cartoon_of_the_day/cartoons/%Y/%Y-%m-%d-cartoon.htm")

# uri = "http://www.xnxx.com/cartoon_of_the_day/cartoons/2009/2009-11-05-cartoon.htm"

# p uri

charset = nil
html = open(uri) do |f|
  charset = f.charset
  f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

p imgURI = doc.xpath('//img').attribute('src').value
p imgAlt = doc.xpath('//img').attribute('alt').value


pigeon = CarrierPigeon.new(:host => "192.168.220.32",
                           :port => "36660",
                           :nick => "xvieos",
                           :channel => "#kmc-xvideos",
                           :join => true)
pigeon.message("#kmc-xvideos", "#{uri}")
pigeon.message("#kmc-xvideos", "#{imgURI}")
pigeon.message("#kmc-xvideos", "#{imgAlt}") if imgAlt != ""
pigeon.die

