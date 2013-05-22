BABELYODA_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'awesome_print'
require 'fileutils'

require_relative 'babelyoda/cli'
require_relative 'babelyoda/commands'
require_relative 'babelyoda/genstrings'
require_relative 'babelyoda/git'
require_relative 'babelyoda/ibtool'
require_relative 'babelyoda/keyset'
require_relative 'babelyoda/localization_key'
require_relative 'babelyoda/localization_value'
require_relative 'babelyoda/logger'
require_relative 'babelyoda/rake'
require_relative 'babelyoda/specification'
require_relative 'babelyoda/tanker'
require_relative 'babelyoda/xib'
