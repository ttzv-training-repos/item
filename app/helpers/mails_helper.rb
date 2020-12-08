module MailsHelper

  def template_content(template_name)
    template_name.template_file.open { |f| File.read(f) }
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
      p template, itemtag
       a = {id: itemtag.id, 
        name: itemtag.name, 
        override_default_mask: override?(template, itemtag),
        default_mask_values: mask_values(itemtag),
        custom_mask_values: mask_values(itemtag, template.id) 
      }
      p a
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
