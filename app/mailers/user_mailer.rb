class UserMailer < ApplicationMailer

  

  def send_email_to_user(user, subject, body)
    @user = user
    @subject = subject
    @body = body
    mail(to: @user.email, subject: @subject, body: @body)
  end


end
