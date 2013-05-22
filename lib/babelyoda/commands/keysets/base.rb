require 'babelyoda/commands/base'

module Babelyoda::Commands::Keysets
  class Base < ::Babelyoda::Commands::Base
    self.abstract_command = true
    self.description = "Manage keysets."
    self.summary = "Manage keysets."
    self.command = 'keysets'
  end
end
