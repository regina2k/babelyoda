require 'awesome_print'
require 'babelyoda/commands/keysets/base'

module Babelyoda::Commands::Keysets
  class Drop < Base
    self.summary = 'Drop remote keysets'
    self.arguments = '[PATTERN ...]'

    def self.options
      [['--drop-all', 'Drop ALL keysets']].concat(super)
    end
    
    def initialize(argv)
      @drop_all = argv.flag?('drop-all')
      @patterns = argv.arguments!
      super
    end
    
    def validate!
      super
      if @patterns.size == 0 && !@drop_all
        help! "You haven't specified keysets to delete. Use --drop-all to drop ALL keysets."
      end
      if @drop_all && @patterns.size > 0
        help! "You should specify no keysets if you use --drop-all, makes sense?"
      end
    end
    
    def run
      keysets = @spec.engine.list
      if @patterns.size > 0
        Babelyoda.logger.info "Dropping keysets: #{keysets}"
        keysets do |fn|
          if @patterns.count{ |pattern| File.fnmatch(pattern, fn) }
            Babelyoda.logger.debug "Dropping: #{keyset_name}"
            @spec.engine.drop_keyset!(keyset_name)
          end
        end
      else
        Babelyoda.logger.info "Dropping ALL keysets: #{keysets}"
      end
    end
  end
end
