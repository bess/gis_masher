#!/opt/local/bin/ruby

# 1. Read in KML file
# 2. Extract lat / long and name
# 3. Write that information to an osv file

require 'rubygems'
require 'nokogiri'

doc = Nokogiri::XML(open("delocator_kml.xml"))
# puts doc
doc.xpath('//xmlns:Placemark', 'xmlns' => "http://earth.google.com/kml/2.0").each do |place|
  # coordinates = place.xpath('//xmlns:Point/coordinates', 'xmlns' => "http://earth.google.com/kml/2.0")
  # puts coordinates
  puts place.xpath('//xmlns:Point/xmlns:coordinates/text()', 'xmlns' => "http://earth.google.com/kml/2.0")
  puts
end
