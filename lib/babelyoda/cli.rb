require 'claide'
require 'colored'

module Babelyoda
  class CLI < CLAide::Command
    self.abstract_command = true

    self.description = 'A simple utility to push/pull l10n resources of an Xcode project to/from the translators.'

    # This would normally default to `cli`, based on the class’ name.
    self.command = 'babelyoda'
  end
end
