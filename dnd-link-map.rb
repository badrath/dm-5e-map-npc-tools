#!/usr/bin/env ruby

#

require 'nokogiri'
require 'json'
require 'open-uri'
require 'logger'

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO

## For CLI input use #ARGV[0])
stand_in_ARGV0 = ARGV[0]
#stand_in_ARGV1 = ARGV[1]

#for static input
#stand_in_ARGV0 = "dev_misc/Astorav2.html" #what to manipulate
#stand_in_ARGV1 = "dev_misc/Astorav2.2.html" #new file name and location


#defunct
#stand_in_ARGV0 = "https://wizardawn.and-mag.com/tool_ftown.php?run=1"
#stand_in_ARGV1 = "/Users/rmarinivision/git/dm-5e-map-npc-tools/dev_misc/test_wget.html" 

LOG.info("input: #{stand_in_ARGV0}")
#LOG.info("output: #{stand_in_ARGV1}")
output_loc = stand_in_ARGV0.sub(".html",".map-link.html")

if(stand_in_ARGV0.include? "http")
#  #defunct because wizardrawn uses a POST command not a GET and so the settings for generation are non-configurable
#  #web map
#  # generator webpage: https://wizardawn.and-mag.com/tool_ftown.php
#  LOG.info("web map recognized...")
#  LOG.info("wget'ing 'complete' webpage and resources...")
#  
#  #download webpage here
#  #wget -p --convert-links http://www.server.com/dir/page.html
#  
#  resource_dir = output_loc.sub(".html","/")
#  system("mkdir '#{resource_dir}'")
##  system("/usr/local/Cellar/wget/1.19.5/bin/wget -E -H -k -K -p -nH -nd -P'#{resource_dir}' -e robots=off '#{stand_in_ARGV0}'") #making system call for wget
#  system("/usr/local/Cellar/wget/1.19.5/bin/wget -P'#{resource_dir}' '#{stand_in_ARGV0}'")
#  LOG.info("'complete' webpage resources will be downloaded to output directory: #{stand_in_ARGV1}")
#  
#  LOG.info("complete")
  LOG.error("direct download of webpage is no longer available.desc Please download the webpage manually and rerun this script on a local copy.")
else
  map_html = stand_in_ARGV0 #path to local html map file
end

#local map
##local html file (with webpage resources folder expected to be in that local dir)
LOG.info("reading in local map...")
map_file = File.read(map_html)
doc = Nokogiri::HTML(map_file)
LOG.info("complete")

#search for map numbers, and link them to their description numbers
LOG.info("searching for, modifying, and linking map numbers...")
doc.xpath('/html/body//div//div//div').each { |link| 
  link['style'] = link['style'].gsub("font-size: 12px","font-size: 18px")
  temp_content = link.content
  link.content = ""
  link.add_child(doc.create_element("a", temp_content, :href => '#bldg_desc_' + temp_content, :name => 'map_' + temp_content))
#  puts(link)
}
doc.xpath('/html/body/div[1]//div').each { |link_color|
  link_color['style'] = link_color['style'] + "color:red; background-color:white;"
}
LOG.info("complete")


#search for the description numbers, and link them to their map numbers
LOG.info("searching for, and linking the description numbers...")
doc.xpath('/html/body//font//b/i/font[@size=3]').each { |desc|
  temp_content = desc.content
  desc.content = ""
  desc.add_child(doc.create_element("a", temp_content, :href => '#map_' + temp_content, :name => 'bldg_desc_' + temp_content))
}
LOG.info("complete")

#write changes to a new file
doc = Nokogiri::HTML(doc.to_html) #'store changes' in doc again as raw html
LOG.info("writing new linked file to #{output_loc}")
File.open(output_loc, 'w'){ |f|
  f.write(doc);
}
LOG.info("complete")

LOG.info("map-description linking complete")
LOG.info("see: #{output_loc}")