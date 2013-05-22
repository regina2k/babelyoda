require 'babelyoda/cli'
require 'babelyoda/specification'

module Babelyoda::Commands
  class Init < Babelyoda::CLI
    self.summary = 'Create a basic bootstrap Babelfile'
    
    def self.options
      [['--force', 'Overwrite the Babelfile if it exists']].concat(super)
    end
    
    def initialize(argv)
      @force = argv.flag?('force')
      super
    end

    def validate!
      super
      if @force.nil? && babelfile?
        help! "A Babelfile exists in the current folder. Use --force to overwrite."
      end
    end    
    
    def run
      Babelyoda::Specification.generate_default_babelfile
    end
    
  private
  
    def babelfile?
      File.exists? 'Babelfile'
    end  
      
  end
end
