module GoogleApiServices
  class GmailAdapter
    require 'google/apis/gmail_v1'

    attr_accessor :settings, :client

    def initialize(settings)
      raise "Authorization client required" if settings[:client].nil?
      @client = settings[:client]
      @service = Google::Apis::GmailV1::GmailService.new
      @service.authorization = @client
    end

    def deliver!(mail)
      message = Google::Apis::GmailV1::Message.new(
        raw: mail.to_s
      )
      @service.send_user_message(
        'me',
        message
      )
    end

  end
end