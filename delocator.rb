#!/opt/local/bin/ruby
require 'open-uri' 
require 'rubygems'
require 'nokogiri'
require 'uri'

i = 0
open('delocator-through300.csv').each{ |x|
  unless i > 10
    # puts x;
     a = x.split(';')
     a.collect! {|y| y.gsub('"','').strip }
     #puts a.inspect
     
     number = a[0]
     name = a[2]
     address = a[4]
     zip = a[7]
     phone = a[8]
     desc = a[14]
 
    puts "number = #{number}\nname = #{name}\naddress = #{address}\nzip = #{zip}\nphone = #{phone}\ndescription = #{desc}\n\n "
    
    doc = Nokogiri::XML(open("http://maps.google.com/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=#{URI.escape(address)},+#{zip}"))

    # only continue if google maps only found a single entry, otherwise it's too ambiguous
    count = puts doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').count
    if count == 1    
      doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').each do |place|
        puts place.inspect
      end
    end
      
  end
  i = i+1
  } 
  
  #require 'net/http' 
  # response = Net::HTTP.get_response('maps.google.com', '/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=2214%20Ivy%20Road,%2022903') 
  # response.code                                             # => "200" 
  # response.body.size                                        # => 21835 
  # response['Content-type'] 
  # # => "text/html; charset=ISO-8859-1" 
  # puts response.body
  
    # doc = Nokogiri::XML(open('http://maps.google.com/maps/geo?key=ABQIAAAAtFasZCbmNcgcbPYf2QzmthRGkJoeiq1SV3lUa19TijJY1xm5GBRktV-c1x5Up1VCIZtc-A1BNhljfg&sensor=false&output=xml&oe=utf8&q=2214%20Ivy%20Road,%2022903'))
    # doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').each do |place|
    #     puts place.inspect
    #   end
  