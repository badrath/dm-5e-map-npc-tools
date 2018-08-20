require 'logger'
require 'json'
require_relative 'creature.rb'

class Improved_initiative
  def initialize(file_path, log_level = 'info', log_out = STDOUT)
    
    # Set logger
    @@log = Logger.new(log_out)
    if log_level.upcase == 'UNKNOWN'
      @@log.level = Logger::UNKNOWN
    elsif log_level.upcase == 'FATAL'
      @@log.level = Logger::FATAL
    elsif log_level.upcase == 'ERROR'
      @@log.level = Logger::ERROR
    elsif log_level.upcase == 'WARN'
      @@log.level = Logger::WARN
    elsif log_level.upcase == 'INFO'
      @@log.level = Logger::INFO
    elsif log_level.upcase == 'DEBUG'
      @@log.level = Logger::DEBUG
      @@log.debug("Debugging messages enabled")
    else
      @@log.level = Logger::DEBUG
      @@log.error("#{log_level} is not a valid log level")
      @@log.warn("Debugging messages enabled by default")
    end
    
    @file_path = file_path;
    ii_json = JSON.parse(File.read(@file_path));
    
    #Creatures.dfsdfs, PlayerCharacters.dsdfsdf, SavedEncounters.sadfasdfsdf
    
    @creatures = Hash.new;
    @creature_list_raw
    @pcs = Hash.new;
    @encounters = Hash.new;
    
    ii_json.keys.each {|k|
      if(k.include? "Creatures.")
        temp = JSON.parse(ii_json[k]);
        @creatures[temp["Name"]] = Creature.new(temp, @@log);
      elsif(k.include? "PlayerCharacters.")
        temp = JSON.parse(ii_json[k]);
        @pcs[temp["Name"]] = Creature.new(temp,@@log);
      elsif(k.include? "SavedEncounters.")
        temp = JSON.parse(ii_json[k]);
        @encounters[temp["Name"]] = temp;
#        @@log.info(temp);
      end
    }
    
    @@log.info("improved initiative initialized.");
    
  end
  
  def get_ability_check_success_rates(stat, dc, creatures, mod_group = 0, group_adv = false)
    creature_successes = Hash.new;
    
    creatures.each do |name, creature|
      mod_total = creature.instance_variable_get("@ability_stats")[stat][:check] + mod_group;
      creature_successes[name] = creature.prob_to_succeed(dc, mod_total).round(2);
    end
    
    return(creature_successes);
  end
  
  def get_ability_save_success_rates(stat, dc, creatures, mod_group = 0, groupd_adv = false)
    creature_successes = Hash.new;
        
    creatures.each do |name, creature|
      mod_total = creature.instance_variable_get("@ability_stats")[stat][:save] + mod_group;
      creature_successes[name] = creature.prob_to_succeed(dc, mod_total).round(2);
    end
    
    return(creature_successes);
  end
  
  def get_skill_check_success_rates(skill, dc, creatures, mod_group = 0, group_adv = false)
    creature_successes = Hash.new;
            
    creatures.each do |name, creature|
      mod_total = creature.instance_variable_get("@ability_stats")[skill][:check] + mod_group;
      creature_successes[name] = creature.prob_to_succeed(dc, mod_total).round(2);
    end
    
    return(creature_successes);
  end
  
end