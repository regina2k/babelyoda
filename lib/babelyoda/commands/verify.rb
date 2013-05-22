require 'babelyoda/commands/base'
require 'babelyoda/specification'

module Babelyoda::Commands
  class Verify < Base
    self.summary = 'Verify all local translations are present'
    
    def run
      combined_keyset = Babelyoda::Keyset.new('babelyoda.verify')
      @spec.strings_files.each do |filename|
        dev_lang_strings = Babelyoda::Strings.new(filename, @spec.development_language).read
        combined_keyset.merge!(dev_lang_strings)
        @spec.localization_languages.each do |language|
          lang_strings = Babelyoda::Strings.new(File.localized(filename, language), language).read
          combined_keyset.merge!(lang_strings)
        end
      end
      combined_keyset.drop_empty!
      
      count = {}
      @spec.all_languages.each { |lang| count[lang.to_sym] = 0}
      
      combined_keyset.keys.each_value do |key|
        @spec.all_languages.each do |lang|
          count[lang.to_sym] += 1 if key.values.has_key?(lang.to_sym)
        end
      end

      total_count = count[@spec.development_language.to_sym]
      Babelyoda.logger.info "#{@spec.development_language}: #{total_count} keys"
      
      all_found = true
      @spec.localization_languages.each do |language|
        lang_count = count[language.to_sym]
        missing_count = total_count - lang_count
        if missing_count > 0
          Babelyoda.logger.error "#{language}: #{lang_count} keys (#{missing_count} translations missing)"
          all_found = false
        end
      end
      exit 1 unless all_found
    end
          
  end
end
