#!/usr/bin/env ruby
##
# TODO:
#   group pc's into parties
#     #['Path'] = "Knights of Ni One Shot" #pc party json field
#   digest saved encounters creatures into their encounter groups
#     each encounter keeps a copy of each creature in the encounter
#   Improved_initiative load option to only retain pcs, and/or creatures, and/or saved encounters
##

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



rob_5e = Improved_initiative.new(stand_in_ARGV0, all_creatures = false, all_pcs = false, all_encounters = true);
encounters = rob_5e.instance_variable_get("@encounters");
#LOG.info(encounters);
#LOG.info("encounters: #{rob_5e.instance_variable_get('@all_encounters')}, creatures: #{rob_5e.instance_variable_get('@all_creatures')}");
encounters.each do |name, encounter|
  LOG.info("#{name} - #{encounter}");
  combatants = encounter.instance_variable_get('@combatants');
  test = rob_5e.get_ability_check_success_rates('Int', 20, combatants);
  test.each do |name, val|
    LOG.info("  #{name} - Int Check - #{val}");
  end
end

#rob_5e = Improved_initiative.new(stand_in_ARGV0, all_encounters = true);
#LOG.info("JSON read into Improved Initiative object");
#
#pcs = rob_5e.instance_variable_get("@pcs");
#
#test = rob_5e.get_ability_check_success_rates('Str', 15, pcs, group_mod = 4);
#LOG.info("group_mod = ".concat(group_mod.to_s));
#test.each do |name, val|
#  LOG.info("#{name} - Str Check - #{val.to_s}");
#end

LOG.info("test_json.rb complete");
#LOG.info("see: #{output_loc}")