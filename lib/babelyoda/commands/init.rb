require 'babelyoda/commands/base'
require 'babelyoda/specification'

module Babelyoda::Commands
  class Init < Base
    self.summary = 'Create a basic bootstrap Babelfile'
    
    def self.options
      [['--force', 'Overwrite the Babelfile if it exists']].concat(super)
    end
    
    def initialize(argv)
      @force = argv.flag?('force')
      super
      @should_load_spec = false
    end

    def validate!
      super
      if @force.nil? && babelfile?
        help! "File exists: '#{@babelfile}'. Use --force to overwrite."
      end
    end    
    
    def run
      Babelyoda::Specification.generate_default_babelfile(@babelfile)
    end
    
  end
end
