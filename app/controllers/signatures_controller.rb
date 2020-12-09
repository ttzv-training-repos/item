class SignaturesController < ApplicationController

  def index
    @templates = Template.where(category: "signature")
  end

  def send_request
    request_data = params[:request_data]
    signature_content = request_data[:messages].values.map do |s|
      { name: s["name"], content: s["content"] }  
    end 
    @signature = Signature.create(content: signature_content)
    
  end

  def download
    p params
  end
  
end
