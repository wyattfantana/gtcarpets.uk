class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: 'no-reply@gtcarpets.uk', reply_to: email, to: 'gareth@gtcarpets.uk', subject: 'New Contact Request')
  end
end