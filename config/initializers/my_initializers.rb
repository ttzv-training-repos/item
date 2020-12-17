MASKED_PASSWORD = '!@#$^%*(!@'

ActionMailer::Base.add_delivery_method :gmail_adapter, GoogleApiServices::GmailAdapter

#for my convenience =)
#file below contains a class that extends String and allows for changing output color
#located under lib/
require 'colorize.rb'