class ContactsController < ApplicationController
  def new
  end

  require 'sendgrid-ruby'

  def create
    # Your email content and parameters
    mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: 'from@example.com')
    mail.subject = 'Subject of the email'
    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: 'gtcarpetsuk@gmail.com')) # Set the recipient email address
    mail.add_personalization(personalization)
    mail.add_content(SendGrid::Content.new(type: 'text/plain', value: 'Email content goes here'))
  
    # Send the email
    begin
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
  
      # Handle response as needed
      if response.status_code.to_i == 202
        redirect_to root_path, notice: 'Your message has been sent successfully!'
      else
        flash.now[:alert] = 'Failed to send email. Please try again later.'
        render :new
      end
    rescue => e
      puts "Error sending email: #{e.message}"
      flash.now[:alert] = 'Failed to send email. Please try again later.'
      render :new
    end
  end  
end
