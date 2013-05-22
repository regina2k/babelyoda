require 'awesome_print'
require 'babelyoda/commands/keysets/base'

module Babelyoda::Commands::Keysets
  class List < Base
    self.summary = 'List remote keysets'
    
    def run
      ap @spec.engine.list
    end
  end
end
