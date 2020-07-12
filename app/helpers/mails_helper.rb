module MailsHelper

  def strip_extension(filename)
    filename.gsub('.html','')
  end

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
  end

  def process_template(file)
    template = Template.find_or_create_by(name: strip_extension(file.original_filename))

    parser = Parsers::TemplateTagParser.new(File.read(file))
    title = parser.value(Parsers::TemplateTagParser.MAIL_TOPIC_TAG)
    title = title[0][0] unless title.empty?
    parser.destroy_tag_with_content(Parsers::TemplateTagParser.MAIL_TOPIC_TAG)
    File.open(file.tempfile, 'w') { |f| f.write(parser.template) }
    template.update(title: title)
    template.template_file.purge if template.template_file.attached?
    template.template_file.attach(file)
    associate_tags(template, parser)
  end

  def associate_tags(template, parser)
    parser.find_tags.each do |tag|
      type = parser.tag_type(tag)
      template_tag = TemplateTag.find_or_create_by(name: tag, tagtype: type)
      TemplateTagging.upsert(template_id: template.id, template_tag_id: template_tag.id)
    end
  end

  def mail_params
    params.require(:message_request)
  end

end
