require_relative 'action.rb'
require 'logger'

class Creature
  
  def initialize(ii_data, logger = false, new_log = false)
    @ii_data = ii_data;
    
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
  
    #calculate percentage to hit for AC and savings and checks for a range of numbers
    #   that would hit
    @ac = @ii_data["AC"]["Value"];
    @ability_mods = Hash.new;
    @ability_mods[:wis] = _calc_mod(@ii_data["Abilities"]["Wis"]);
    
      
      
      
#    @@log.info(@ii_data);
#    @@log.info("\t #{@ii_data['Actions'][0]}");
    
    
    
#    @actions = Hash.new
#    
#    @@log.info(@ii_data['Name']);
#    @ii_data['Actions'].each {|action|
#     @actions[action['Name']] = Action.new(action, logger = @@log);
#    }
    
    @@log.info("---- Next Creature -------");
  end
  
  def _calc_mod (raw, prof = 0)
    return(
      ((raw - 8) / 2).floor(-2) + prof
    );
  end
  
  def prob_to_hit (atk, adv = false)
    return(
      prob_to_succeed(@ac, @ii_data[""])
    )
  end
  
  def prob_to_succeed (dc, modifier, adv = false)
    
    dice_type = 20; # d20
    
    if(adv)
      num_dice = 2.0;
    else
      num_dice = 1.0;
    end
    
    dc = dc.to_f;
    modifier = modifier.to_f;
    
    return (1 - ((dice_type - (dice_type - dc + 1 + modifier)) / dice_type) ** num_dice);
    
  end
  
end