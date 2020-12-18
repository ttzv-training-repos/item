module TemplatesHelper

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
  end

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

  def process_template(file, category)
    template = Template.find_or_create_by(name: strip_extension(file.original_filename), category: category)
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

  #returns values of tags after mask application for currently held users
  #will use default Itemtag mask if template_id is not provided
  #returned object is a hash
  
  def itemtags_hash(template)
    template.itemtags.map do |itemtag|
       a = {id: itemtag.id, 
        name: itemtag.name, 
        override_default_mask: override?(template, itemtag),
        default_mask_values: mask_values(itemtag),
        custom_mask_values: mask_values(itemtag, template.id),
        store_value: store_value?(template, itemtag)
      }
    end
  end

  def json_data
    category = params[:category]
    json_data = Hash.new
    Template.where(category: category).each do |t|
      json_data.merge!(
        {
        t.name => {
          id: t.id,
          name: t.name,
          title: t.title,
          content: template_content(t),
          tags: itemtags_hash(t)
        }
      })
    end
    {template_data: json_data}
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

  def mask_values(itemtag, template_id=nil)
    hash = Hash.new
    current_user.user_holders.each do |ad_user|
      user = AdUser.find_by(objectguid: ad_user.objectguid)
      hash[user.id] = itemtag.apply_mask(user.id, template_id)
    end
    hash
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

  def store_value?(template, itemtag)
    tcm = TemplateTagging.find_by(
      template_id: template.id,
      itemtag_id: itemtag.id
    ).tag_custom_mask
    return tcm.store_value if tcm
    false
  end

end
