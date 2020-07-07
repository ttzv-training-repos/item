module SettingsHelper

  def settings_params
    params.require(:tags).
    permit(TemplateTag.where.not(name: "itemtag-mail-topic").pluck(:name))
  end

end
