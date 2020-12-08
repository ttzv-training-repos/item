module MailsHelper

  def mail_params
    params.require(:message_request).permit(:sender,
                                 messages: [
                                   :subject,
                                   :recipient,
                                   :content
                                 ])
  end

end
