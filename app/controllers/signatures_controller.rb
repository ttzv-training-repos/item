class SignaturesController < ApplicationController
  require 'zip'

  def index
    @templates = Template.where(category: "signature")
  end

  def send_request
    @signature = Signature.find_or_create_by(user_id: current_user.id)
    request_data = params[:request_data]
    signature_content = request_data[:messages].values.map do |s|
      { name: s["recipient"].split('@')[0], content: s["content"] }  
    end 
    @signature.update(content: signature_content.to_json)
  end

  
  def download
    signature = Signature.find(params[:signature_id])
    signature_content_zip = signature.zipped
    send_data(signature_content_zip.read, filename: 'signatures.zip')
  end
  
end
