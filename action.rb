require 'logger'

class Action
  
  def initialize (raw, logger = false, new_log = false)
    @raw_data = raw;
    
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
    
    if(@raw_data['Name'].downcase === 'multiattack')
      @@log.info("Multiattack found. Converting...");
      @type = 'multiattack';
      @attacks = Hash.new;
      parse_multiattack(@raw_data["Content"]);
    else
      @type = 'action';
    end
    
    @@log.info(@raw_data);
  end
  
  def parse_multiattack(content_str)
    content = content_str.strip(".").split(" ");
    i = 0;
    while i 
  end
  
  
  
end