module MailsHelper

  def strip_extension(filename)
    filename.gsub('.html','')
  end

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
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

  def associate_tags(template, parser)
    parser.find_tags.each do |tag|
      template_tag = Itemtag.find_or_create_by(name: tag, display_name: Parsers::ItemtagParser.tag_display_name(tag))
      TemplateTagging.upsert(template_id: template.id, itemtag_id: template_tag.id)
    end
  end

  def mail_params
    params.require(:message_request).permit(:sender,
                                 messages: [
                                   :subject,
                                   :recipient,
                                   :content
                                 ])
  end

  #returns values of tags after mask application for currently held users
  #will use default Itemtag mask if template_id is not provided
  #returned object is a hash
  def mask_values(itemtag, template_id=nil)
    hash = Hash.new
    current_user.user_holders.each do |ad_user|
      user = AdUser.find_by(objectguid: ad_user.objectguid)
      hash[user.id] = itemtag.apply_mask(user.id, template_id)
    end
    hash
  end

  def itemtags_hash(template)
    template.itemtags.map do |itemtag|
      {id: itemtag.id, 
        name: itemtag.name, 
        override_default_mask: override?(template, itemtag),
        default_mask_values: mask_values(itemtag),
        custom_mask_values: mask_values(itemtag, template.id) 
      }
    end
  end

  def override?(template, itemtag)
    tagging = TemplateTagging.find_by(
      template_id: template.id,
      itemtag_id: itemtag.id
    )
    return false if tagging.nil?
    return false if tagging.tag_custom_mask.nil?
    tagging.tag_custom_mask.use
  end
end
