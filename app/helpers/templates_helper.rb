module TemplatesHelper

  def template_params
    params.require(:template).permit(:name, :category, :title, :content)
  end

  def params_nocontent(hash)
    hash.to_h.filter { |h| h != "content" }
  end
end
