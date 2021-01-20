module SmsGatewayHelper

  def sms_params
      params.require(:request_data).permit(:sender,
                                    messages: [
                                      :user_id,
                                      :recipient,
                                      :phone_number,
                                      :template_id,
                                      :name,
                                      :subject,
                                      :content,
                                      :tagMap => {}
                                    ])
    end

end
