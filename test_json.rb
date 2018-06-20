#!/usr/bin/env ruby

#

require 'json'
require 'logger'

LOG = Logger.new(STDOUT)
LOG.level = Logger::INFO

## For CLI input use #ARGV[0])
#stand_in_ARGV0 = ARGV[0]
##stand_in_ARGV1 = ARGV[1]

#for static input
stand_in_ARGV0 = "dev_misc/improved-initiative.json" #what to manipulate
#stand_in_ARGV1 = "dev_misc/Astorav2.2.html" #new file name and location

ii_file = File.read(stand_in_ARGV0)
ii_json = JSON.parse(ii_file)
test_npc_encounter_folder = JSON.parse(ii_json['ImprovedInitiative.SavedEncounters.npc_encounter_folder-npc_encounter'])


LOG.info("json reading complete")
LOG.info("see: #{output_loc}")