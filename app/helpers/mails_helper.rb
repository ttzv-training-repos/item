module MailsHelper

  def mail_params
    params.require(:request_data).permit(:sender,
                                 messages: [
                                   :user_id,
                                   :recipient,
                                   :template_id,
                                   :name,
                                   :subject,
                                   :content,
                                   :tagMap => {}
                                 ])
  end

  def store_itemtag_values(tag_map, template_id, ad_user_id)
    template = Template.find(template_id.to_i)
    tag_map.each do |tag_name, value|
      storage_key = "#{template.name} #{tag_name.split("-")[1..-1].join(" ")}"
      itemtag = Itemtag.find_by(name: tag_name)
      if itemtag.store? 
        AdUser.find(ad_user_id.to_i).ad_user_detail.storage_set(storage_key, value)
      else 
        if itemtag.store?(template)
          AdUser.find(ad_user_id.to_i).ad_user_detail.storage_set(storage_key, value)
        end
      end
    end
  end

end
