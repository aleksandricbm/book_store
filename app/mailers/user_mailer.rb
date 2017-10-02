class UserMailer < ApplicationMailer
  default from: 'ai@bookstore.com'

  def confirmation_mail(email, pass)
    @email = email
    @pass = pass
    mail(to: @email, subject: 'Confirmation of registration')
  end
end
