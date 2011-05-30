
module System
  
  # Log is a global system logger that abstracts the source logger and configuration
  # settings required by the source logger.  Applications can simply use the logger 
  # as illustrated below:
  #
  # example of logging an info message:
  # Log.info "simple info message"
  #
  # example of logging a debug message:
  # Log.debug "simple debug message"
  #
  # example of logging a warning message:
  # Log.warn "simple warning message"
  #
  # example of logging an error message:
  # Log.error "simple error message"
  #
  class Log

    # default logger instance.
    #
    attr_accessor :log, :level
    
    # Initializes this dispatcher with default vertical and logger.
    #  
    def self.init
      @log = Logger.new(Configuration.logger_path, 10, 1024000)
      @log.level = Configuration.logger_level
      @log
    end
    
    def self.level=(level)
      return if level == nil
      case level
        when 'info'
          logger.level = Logger::INFO
          @level = level
          
        when 'debug'
          logger.level = Logger::DEBUG
          @level = level
          
        when 'warn'
          logger.level = Logger::WARN
          @level = level
          
        when 'error'
          logger.level = Logger::ERROR
          @level = level
          
        when 'fatal'
          logger.level = Logger::FATAL
          @level = level
          
        end
    end
    
    def self.info(message)
      logger.info(message)
    end
    
    def self.info?
      logger.info?
    end
    
    def self.warn(message)
      logger.warn(message)
    end
    
    def self.warn?
      logger.warn?
    end
    
    def self.debug(message)
      logger.debug(message)
    end
    
    def self.debug?
      logger.debug?
    end
    
    def self.error(message)
      logger.error(message)
    end
    
    def self.error?
      logger.error?
    end
    
    def self.fatal(message)
      logger.fatal(message)
    end
    
    def self.fatal?
      logger.fatal?
    end
    
    def self.logger
      defined?(@log) ? @log : init
    end
       
  end
end