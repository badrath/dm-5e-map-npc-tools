require_relative 'creature.rb'
require 'logger'

class Encounter
  
  def initialize(ii_data, logger = false, new_log = false)
    
    # Set logger
    if(logger)
      @@log = logger;
    else
      log_out = new_log[0];
      log_level = new_log[1];
      @@log = Logger.new(log_out);
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
    end
    
    @combatants = Hash.new;
#    @@log.info("ii_data #{ii_data}");
    ii_data.keys.each {|k|
#      @@log.info("k #{k}");
      if(k.include? "Combatants")
        ii_data[k].each { |creature|
#          @@log.info("creature #{creature}");
          temp = creature["StatBlock"];
#          @@log.info("temp #{temp}");
          @combatants[temp["Name"]] = Creature.new(temp, @@log);
        }
      end
    }
    
    @@log.info("---- #{ii_data["Name"]} Loaded -------");
  end
  
end