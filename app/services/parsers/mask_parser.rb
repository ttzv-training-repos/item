module Parsers
  class MaskParser

    attr_accessor :text

    def initialize(text)
      @text = text
    end

    def insert(options)
      options_missing?(options, [:at, :text])
      return @text if values_nil? options
      return @text.insert(options[:at].to_i, options[:text])
    end

    def replace(options)
      options_missing?(options, [:search, :replacement])
      return @text if values_nil? options
      return @text.gsub!(options[:search], options[:replacement])
    end

    def remove(options)
      options_missing?(options, [:index])
      return @text if values_nil? options
      index = options[:index].to_i
      return @text if index >= @text.length
      @text[index] = ''
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