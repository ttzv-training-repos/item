module MailsHelper

  def strip_extension(filename)
    filename.gsub('.html','')
  end

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
  end

  def process_template(file)
    parser = Parsers::TemplateTagParser.new(File.read(file))
    title = parser.value(Parsers::TemplateTagParser.MAIL_TOPIC_TAG)
    title = title[0][0] unless title.empty?
    parser.destroy_tag_with_content("mailtag-topic")
    File.open(file.tempfile, 'w') { |f| f.write(parser.template) }
    {title: title}
  end

  def associate_tags(template)
    parser = Parsers::TemplateTagParser.new(template.template_file.open { |f| File.read(f) })
    parser.find_tags.each do |tag|
      template_tag = TemplateTag.find_by(name: tag)
      TemplateTagging.upsert(template_id: template.id, template_tag_id: template_tag.id)
    end
  end

end
