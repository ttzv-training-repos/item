module TemplateTagsHelper

  def tag_params
    params.require(:tag).permit(:name,
                                :description,
                                :store_value,
                                :default_value_mask,
                                :template_type);
  end

  def tag_name_type(name, type)
    typelist = ['itemtag-mail-','itemtag-sms-','itemtag-signature-']
    n = name.downcase.strip
    typelist.each do |t|
      if t.include? type
        n = t + n
        return n
      end
    end
  end

end
