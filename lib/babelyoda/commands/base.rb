require 'awesome_print'
require 'claide'
require 'colored'

require 'babelyoda/logger'
require 'babelyoda/specification'

module Babelyoda::Commands
  class Base < CLAide::Command
    self.abstract_command = true
    self.description = 'A simple utility to push/pull l10n resources of an Xcode project to/from the translators.'
    self.command = 'babelyoda'
    
    def self.options
      [
        ['--babelfile=FILE', "Use another file instead of the #{Babelyoda::Specification::FILENAME}"],
        ['--debug', "Output detailed debug info"]
      ].concat(super)
    end
    
    def initialize(argv)
      @debug = argv.flag?('debug')
      @babelfile = argv.option('babelfile', Babelyoda::Specification::FILENAME)
      @should_load_spec = true
      super
    end

    def validate!
      super
      if self.class.command == Babelyoda::Commands::Base.command
        help!
      end
      if @should_load_spec && !babelfile?
        help! "Babelfile not found: '#{@babelfile}'. Use the init command to create one."
      end
      Babelyoda::Logger.setup(@debug, verbose?)
      load_specification if @should_load_spec
    end    

    def babelfile?
      File.exists? @babelfile
    end  

  private
      
    def load_specification
      @spec = Babelyoda::Specification.load(@babelfile)
      unless @spec
        help! "Error loading the Babelfile: '#{@babelfile}'."
      end
      ap @spec if @debug
    end
      
  end
end
