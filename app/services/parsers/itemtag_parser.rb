module Parsers
  class ItemtagParser
    attr_accessor :template

    def initialize(template)
      @tags = Itemtag.pluck(:name)
      @template = template
    end

    def self.MAIL_TOPIC_TAG
      "itemtag-mail-topic"
    end

    def swap(name, value)
      if @tags.include?(name)
        tag = as_tag(name)
        return @template.gsub!(/(?<=#{tag[:begin]})(.*?)(?=#{tag[:end]})/, value)
      else
        raise "No such tag exists: #{name}"
      end
    end
    
    def value(name)
        tag = as_tag(name)
        return @template.scan(/(?<=#{tag[:begin]})(.*?)(?=#{tag[:end]})/)
    end

    def find_tags
      matches = @template.scan(/(?:<|<\/)itemtag-\w+-\w+>/)
      validate(matches).collect { |m| strip(m) }
    end

    def destroy_tag_with_content(name)
      tag = as_tag(name)
      @template.gsub!(/#{tag[:begin]}(.*?)#{tag[:end]}/, '')
    end

    def self.tag_type(name)
      name.scan(/(?<=-)(.*?)(?=-)/).flatten[0]
    end

    def self.tag_display_name(name)
      name.gsub(/itemtag-\w+-/,'').strip.capitalize
    end
    
    private
    
    def as_tag(name)
      tag_begin = "<#{name}>"
      tag_end = "</#{name}>"
      {begin: tag_begin, end: tag_end}
    end

    def validate(tags)
      tags.filter.with_index do |t, i|
        if i.even?
          is_a_pair?(tags[i], tags[i+1])
        end
      end
    end

    def is_opening_tag?(tag)
      !tag.include?('/') and tag[0] == '<'
    end

    def is_closing_tag?(tag)
      tag[0..1] == '</'
    end

    def is_a_pair?(tag_open, tag_end)
      is_opening_tag?(tag_open) and is_closing_tag?(tag_end) and strip(tag_open) == strip(tag_end)
    end

    def strip(tag)
      tag.gsub(/[<\/>]/, '')
    end
  end
end