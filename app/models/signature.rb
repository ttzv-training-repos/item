class Signature < ApplicationRecord
    belongs_to :user

  # credit to https://lorefnon.me/2014/09/03/in-memory-zipping-ruby.html
  def zipped
    signature_content = JSON.parse(self.content, symbolize_names: true)
    file_stream = Zip::OutputStream.write_buffer do |zip|
      signature_content.each do |sign|
      zip.put_next_entry("#{sign[:name]}.htm")
      zip.print(sign[:content])
      end
    end
    file_stream.rewind
    file_stream
  end

end
