module Parsers
  class TemplateTagParser

    attr_accessor :template

    def initialize(template)
      @tags = TemplateTag.pluck(:name)
      @template = template
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
        raise "No such tag exists: #{name}"
      end
    end
    
    private
    
    def as_tag(name)
      tag_begin = "<#{name}>"
      tag_end = "</#{name}>"
      {begin: tag_begin, end: tag_end}
    end

  end
end