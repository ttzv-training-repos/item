module Parsers
  class TemplateTagParser
    attr_accessor :template

    def initialize(template)
      
      @tags = TemplateTag.pluck(:name)
      @template = template
    end

    def self.MAIL_TOPIC_TAG
      "mailtag-topic"
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
      if @tags.include?(name)
        tag = as_tag(name)
        return @template.scan(/(?<=#{tag[:begin]})(.*?)(?=#{tag[:end]})/)
      else
        return ''
      end
    end

    def find_tags
      matches = @template.scan(/(?:<|<\/)mailtag-\w+>/)
      validate(matches).collect { |m| strip(m) }
    end

    def destroy_tag_with_content(name)
      tag = as_tag(name)
      @template.gsub!(/#{tag[:begin]}(.*?)#{tag[:end]}/, '')
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