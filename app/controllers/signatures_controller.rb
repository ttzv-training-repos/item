class SignaturesController < ApplicationController

  def index
    @templates = Template.where(category: "signature")
  end

  def send_request
    data = "<p>Paraghaph</p><br>test"
    send_data(data, :filename => "test.htm", disposition: "inline")
  end
  
end
