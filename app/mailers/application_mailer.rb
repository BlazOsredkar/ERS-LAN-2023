class ApplicationMailer < ActionMailer::Base
  default from: "ERŠ LAN Party 2023/24 <#{ENV['MAIL_USER']}>"
  layout "mailer"
end
