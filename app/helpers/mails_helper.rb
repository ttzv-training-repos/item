module MailsHelper

  def strip_extension(filename)
    filename.gsub('.html','')
  end

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
  end

  def associate_tags(template)
    parser = Parsers::TemplateTagParser.new(template_content(template))
    parser.find_tags.each do |tag|
      template_tag = TemplateTag.find_by(name: tag)
      TemplateTagging.upsert(template_id: template.id, template_tag_id: template_tag.id)
    end
  end

end
