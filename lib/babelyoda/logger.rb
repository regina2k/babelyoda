require 'log4r-color'

module Babelyoda
  def self.logger
    Logger.instance
  end
  
  class Logger
    def self.setup(debug, verbose, colorize)
      unless @logger
        Log4r::Logger.root.level = debug ? Log4r::DEBUG : (verbose ? Log4r::INFO : Log4r::WARN)
        @logger = Log4r::Logger.new('babelyoda')

        if colorize
          Log4r::ColorOutputter.new 'color', {
            :colors => { 
              :debug  => :black, 
              :info   => :blue, 
              :warn   => :yellow, 
              :error  => :red, 
              :fatal  => {:color => :red, :background => :white} 
            },
            :formatter => Log4r::PatternFormatter.new(:pattern => "%l %m")
          }

          @logger.add('color')
        end
      end
    end
    
    def self.instance
      @logger
    end
  end
end
