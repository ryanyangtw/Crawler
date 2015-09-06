require 'rubygems'
require 'open-uri' #自動處理 302 status
require 'nokogiri'
# require 'open-air' # already part of your ruby install
require 'pry'
# uri = URI('http://5xruby.tw')
# Net::Http.get(uri)

url =  ARGV[0] # ruby crawler.rb 'http://getinkbox.com/collections/all'
uri = URI(url) #'http://getinkbox.com/collections/all'
doc = Nokogiri::HTML(open(uri))
image_tags = doc.css('div.product_image img')
image_tags.each do |image_tag|

  if image_tag['src']
    first_image_uri = image_tag['src'].to_s
    first_image_uri = 'http:' + first_image_uri
    first_image_uri = /^http.*(jpg|png)/.match(first_image_uri).to_s
    File.open(File.basename(first_image_uri),'wb'){ |f| f.write(open(first_image_uri).read) }
  end


  if image_tag['onmouseover']
    second_image_uri = image_tag['onmouseover'].to_s
    second_image_uri = 'http://' + /cdn.*(jpg|png)/.match(second_image_uri).to_s
    puts second_image_uri
    File.open(File.basename(second_image_uri),'wb'){ |f| f.write(open(second_image_uri).read) }
  end

end


# doc.css('div.product_image img')


# div.product_image img 
# src
# onmouseover="this.src=