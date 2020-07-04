module MailsHelper

  def strip_extension(filename)
    filename.gsub('.html','')
  end

end
