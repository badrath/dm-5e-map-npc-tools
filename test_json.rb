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
pcs = rob_5e.instance_variable_get("@pcs");
test = rob_5e.get_ability_check_success_rates('Str', 15, pcs, group_mod = 4);
puts("group_mod = ".concat(group_mod.to_s));
test.each do |name, val|
  puts("#{name} - Str Check - #{val.to_s}");
end

LOG.info("json reading complete");
#LOG.info("see: #{output_loc}")