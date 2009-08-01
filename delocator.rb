#!/opt/local/bin/ruby
require 'open-uri' 
require 'rubygems'
require 'nokogiri'

open('delocator-through300.csv').each{ |x|
  
# puts x;
 a = x.split(';')
 a.collect! {|y| y.gsub('"','').strip }
 #puts a.inspect
 puts "#{a[2]} / #{a[4]} / #{a[7]}"
 
 #http://maps.google.com/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=2214%20Ivy%20Road,%2022903
  
  } 
  
  #require 'net/http' 
  # response = Net::HTTP.get_response('maps.google.com', '/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=2214%20Ivy%20Road,%2022903') 
  # response.code                                             # => "200" 
  # response.body.size                                        # => 21835 
  # response['Content-type'] 
  # # => "text/html; charset=ISO-8859-1" 
  # puts response.body
  
    doc = Nokogiri::XML(open('http://maps.google.com/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=2214%20Ivy%20Road,%2022903'))
    doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').each do |place|
        puts place.content
      end
  