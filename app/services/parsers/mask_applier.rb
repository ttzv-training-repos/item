module Parsers
  class MaskApplier

    attr_accessor :text

    def initialize(text)
      @text = String.new(text)
    end

    def insert(options)
      options_missing?(options, [:index, :value])
      return @text if values_nil? options
      return @text.insert(options[:index].to_i, options[:value])
    end

    def replace(options)
      options_missing?(options, [:match, :search, :value])
      return @text if values_nil? options
      if options[:match] === 'regexp'
        return @text.gsub!(Regexp.new(options[:search]), options[:value])
      end
      if options[:match] === 'text'
        return @text.gsub!(options[:search], options[:value])
      end
    end

    def remove(options)
      options_missing?(options, [:match, :value])
      return @text if values_nil? options
      if options[:match] === 'regexp'
        return @text.gsub!(Regexp.new(options[:value]), '')
      end
      if options[:match] === 'text'
        return @text.gsub!(options[:value], '')
      end
      if options[:match] === 'index'
        index = options[:value].to_i
        return @text if index >= @text.length
        @text[index] = ''
        return @text
      end       
    end

    def other(options)
      return @text if values_nil? options
      @text.upcase! if options[:upcase]
      @text.downcase! if options[:downcase]
      @text.capitalize! if options[:capitalize]
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