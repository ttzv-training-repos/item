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
end
