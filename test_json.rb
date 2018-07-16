#!/usr/bin/env ruby

#

require 'json'
require 'logger'
require_relative 'improved_initiative.rb'

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO

## For CLI input use #ARGV[0])
#stand_in_ARGV0 = ARGV[0]
##stand_in_ARGV1 = ARGV[1]

#for static input
stand_in_ARGV0 = "dev_misc/Rob_5e_improved-initiative.json" #what to manipulate
#stand_in_ARGV1 = "dev_misc/Astorav2.2.html" #new file name and location

rob_5e = Improved_initiative.new(stand_in_ARGV0);

#ii_file = File.read(stand_in_ARGV0)
#ii_json = JSON.parse(ii_file)
#
#dragons = Array.new
#creatures = Hash.new
#ii_json.keys.each {|k|
#  if(k.include? "Creatures.")
#    temp = JSON.parse(ii_json[k]);
#    creatures[temp["Name"]] = temp;
#    
#    if(temp["Name"].downcase.include? "dragon")
#      dragons.push(temp["Name"]);
#    end
#      
#  end
#  
#}
#
#puts(dragons);
#puts(creatures["Green Gaping Gutter Dragon"]);
LOG.info("json reading complete")
#LOG.info("see: #{output_loc}")