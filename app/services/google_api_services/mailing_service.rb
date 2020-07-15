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

    def send(message)
      builder = GoogleApiServices::MessageBuilder.new
      message = builder.to("tomasz.zwak@atal.pl")
        .from("JO")
        .subject(message)
        .body("Hello world!").message

      @service.send_user_message('me', message)
    end

    private

    def header(properties)
      
    end

  end
end