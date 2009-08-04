#!/opt/local/bin/ruby

# 1. Read in KML file
# 2. Extract lat / long and name
# 3. Write that information to an osv file

require 'rubygems'
require 'nokogiri'

doc = Nokogiri::XML(open("delocator_kml.xml"))
# puts doc

open('output', 'w') do |f|
  
  doc.xpath('//xmlns:Placemark', 'xmlns' => "http://earth.google.com/kml/2.0").each do |place|
    # coordinates = place.xpath('//xmlns:Point/coordinates', 'xmlns' => "http://earth.google.com/kml/2.0")
    # puts coordinates
    coordinates = place.xpath('./xmlns:Point/xmlns:coordinates/text()', 'xmlns' => "http://earth.google.com/kml/2.0").to_s.split(',')
    north = Float(coordinates[0])
    east = Float(coordinates[1])
    name = place.xpath('./xmlns:name/text()', 'xmlns' => "http://earth.google.com/kml/2.0").to_s
    puts "#{north} #{east} #{name}"
    puts
  
    len = 1+name.length; # Include the NULL (added by 'pack')
    siz = 13+len; # Size of three first fields plus the string above
    
    # puts "north = #{(north*1E5).to_i}"
  
    # syswrite (OV2, pack ("C I i i Z$len", 2, $siz,
                        # int($ARGV[1]*1E5), int($ARGV[0]*1E5), $ARGV[2]));
    f << [2, siz, (north*1E5).to_i, (east*1E5).to_i, name].pack("C I i i Z#{len}")
  end
end