#!/opt/local/bin/ruby
require 'open-uri' 
require 'rubygems'
require 'nokogiri'
require 'uri'


# open up the output file and zero it out
output = "delocator_kml.xml"
open(output, 'w')

input = "delocator-through300.csv"

kml = Nokogiri::XML::Document.new
kml.root = Nokogiri::XML::Node.new("kml", kml)
document = Nokogiri::XML::Node.new("Document", kml)
kml.root.add_child(document)

i = 0
open(input).each{ |x|
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
    count = doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').count
    if(count==1)    
      doc.xpath('//google:Placemark', 'google' => 'http://earth.google.com/kml/2.0').each do |place|
        puts place.class
        #puts place.inspect
        place['id'] = number # replace the fake id with the id from the file
        
        name_node = Nokogiri::XML::Node.new("name", kml)
        name_node.content = name
        desc_node = Nokogiri::XML::Node.new("description", kml)
        desc_node.content = desc
        
        place.add_child(name_node)
        place.add_child(desc_node)
        document.add_child(place)
      end
    end
      
  end
  i = i+1
  } 
  
  open(output, 'w') { |f| f << kml.to_xml }
  
  
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
  