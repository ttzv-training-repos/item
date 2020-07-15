module GoogleApiServices
  class MessageBuilder
    attr_reader :message
    public

    def initialize
      @message = Google::Apis::GmailV1::Message.new
      @message.payload = Google::Apis::GmailV1::MessagePart.new
      @message.payload.headers = Array.new
      @message.payload.body = Google::Apis::GmailV1::MessagePartBody.new
    end

    def to(recipient)
      header = Google::Apis::GmailV1::MessagePartHeader.new
      header.update!(name: :recipient, value: recipient)
      @message.payload.headers.push(header)
      self
    end

    def from(sender)
      header = Google::Apis::GmailV1::MessagePartHeader.new
      header.update!(name: :sender, value: sender)
      @message.payload.headers.push(header)
      self
    end

    def subject(subject)
      #prevent multiple subjects
      header = Google::Apis::GmailV1::MessagePartHeader.new
      header.update!(name: :subject, value: subject)
      @message.payload.headers.push(header)
      self
    end

    def body(text)
      @message.payload.body.data = text
      self
    end

    def self.from_hash(hash)
      #todo
    end

    private

    def attachment
      
    end

  end
end