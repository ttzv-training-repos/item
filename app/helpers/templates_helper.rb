module TemplatesHelper

  def template_params
    params.require(:template).permit(:name, :category, :title, :content)
  end

  def params_nocontent(hash)
    hash.to_h.filter { |h| h != "content" }
  end

  def create_and_associate_nonexistent_tags(template_content, template_id)
    parser = Parsers::ItemtagParser.new(template_content)
    existing_tags = Itemtag.all.pluck(:name)
    new_tags = parser.find_tags.filter{ |t| !existing_tags.include? t }
    new_tags.each do |t|
      new_itemtag = Itemtag.create_from_tag_string(t)
      new_itemtag.associate_with(template_id)
    end
  end

  def process_template(file)
    template = Template.find_or_create_by(name: strip_extension(file.original_filename))
    parser = Parsers::ItemtagParser.new(File.read(file))
    title = parser.value(Parsers::ItemtagParser.MAIL_TOPIC_TAG)
    title = title[0][0] unless title.empty?
    p title
    parser.destroy_tag_with_content(Parsers::ItemtagParser.MAIL_TOPIC_TAG)
    File.open(file.tempfile, 'w') { |f| f.write(parser.template) }
    template.update(title: title)
    template.template_file.purge if template.template_file.attached?
    template.template_file.attach(file)
    associate_tags(template, parser)
  end

  private

  def associate_tags(template, parser)
    parser.find_tags.each do |tag|
      template_tag = Itemtag.find_or_create_by(name: tag, display_name: Parsers::ItemtagParser.tag_display_name(tag))
      TemplateTagging.upsert(template_id: template.id, itemtag_id: template_tag.id)
    end
  end

  def strip_extension(filename)
    filename.gsub('.html','')
  end

end
