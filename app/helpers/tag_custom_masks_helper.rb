module TagCustomMasksHelper

  def mask_params
    params.require(:tag_custom_mask).permit(:value)
  end

end
