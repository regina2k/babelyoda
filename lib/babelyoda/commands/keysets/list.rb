require 'awesome_print'
require 'babelyoda/commands/keysets/base'

module Babelyoda::Commands::Keysets
  class List < Base
    self.summary = 'List remote keysets'

    def self.options
      [['--awesome-print', 'Output the results in a human-friendly way']].concat(super)
    end

    def initialize(argv)
      @awesome_print = argv.flag?('awesome-print')
      super
    end
    
    def run
      keysets = @spec.engine.list
      if @awesome_print
        ap keysets, ap_options
      else
        keysets.each { |ks| puts ks }
      end
    end
    
    def ap_options
      result = {}
      result[:plain] = true unless colorize_output?
      result
    end
  end
end
