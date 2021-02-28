class TemplateMailer < ApplicationMailer

  def config(user, password)
    user_smtp_setting = user.smtp_setting
    password = user_smtp_setting.password if password.nil?
    if user_smtp_setting
      ActionMailer::Base.smtp_settings = {
        sender:               user_smtp_setting.sender,
        address:              user_smtp_setting.address,
        port:                 user_smtp_setting.port,
        domain:               user_smtp_setting.domain,
        user_name:            user_smtp_setting.user_name,
        password:             password,
        authentication:       user_smtp_setting.authentication,
        enable_starttls_auto: user_smtp_setting.tls 
      }
    else
      return false
    end
  end
 
  def template_mail(options)
    recipients = options[:recipients]
    subject = options[:subject]
    body_html = options[:body_html]

    mail_hash = {
      from: "itemwebapp@gmail.com",
      to: recipients,
      subject: subject,
      content_type: 'text/html; charset=UTF-8',
      body: body_html
    }
    p params[:client]
    if params[:client]
      ActionMailer::Base.gmail_adapter_settings = {
        client: params[:client]
      }
      mail_hash[:delivery_method] = :gmail_adapter
    else
      config(params[:user], params[:password])
    end

    mail(mail_hash)
  end


end
