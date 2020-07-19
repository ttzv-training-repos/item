module GoogleApiServices
  require 'google/apis/gmail_v1'
  class MailingService

    def initialize(client)
      @service = Google::Apis::GmailV1::GmailService.new
      @service.authorization = client
    end

    def parse_request(request_hash)
      message = Google::Apis::GmailV1::Message.new
      message_part = Google::Apis::GmailV1::MessagePart.new
      message_part_header = Google::Apis::GmailV1::MessagePartHeader.new
      message_part_body = Google::Apis::GmailV1::MessagePartBody.new

    end

    def send(mail_request={})
      raise "Sender address is required" if mail_request[:sender].nil?
      raise "Messages are required" if mail_request[:messages].nil?

      sender =  mail_request[:sender]
      messages = mail_request[:messages]

      messages.each do |m|
        mail = Mail.new do
          from sender
          to 'tomasz.zwak@gmail.com'
          subject m["template"]["title"]
          html_part do
            content_type 'text/html; charset=UTF-8'
            body m["template"]["content"]
          end
        end
        message = Google::Apis::GmailV1::Message.new
        message.raw = mail.to_s
        @service.send_user_message('me', message)
      end
    end

    private

    def header(properties)
      
    end

  end
end