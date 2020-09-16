module ItemtagsHelper

  def itemtag_params
    params.require(:itemtag)
    .permit(:name,
            :display_name,
            :description,
            :default_value_mask,
            :store_value)
  end

end
