module Parsers
  class MaskParser

    attr_accessor :text

    def initialize(text)
      @text = text
    end

    def insert(options)
      options_missing?(options, [:at, :text_to_insert])
      return @text if values_nil? options
      return @text.insert(options[:at], options[:text_to_insert])
    end

    def replace(options)
      options_missing?(options, [:searched, :replacement])
      return @text if values_nil? options
      return @text.gsub!(options[:searched], options[:replacement])
    end

    def remove(options)
      options_missing?(options, [:index])
      return @text if values_nil? options
      return @text if options[:index] >= @text.length
      @text[options[:index]] = ''
      return @text
    end

    private

    def options_missing?(options_hash, required_keys)
      keys = required_keys - options_hash.keys 
      raise ArgumentError.new "Keys missing in options hash: #{keys}" unless keys.empty?
    end

    def values_nil?(options)
      return options.values.include?(nil)
    end

  end
end