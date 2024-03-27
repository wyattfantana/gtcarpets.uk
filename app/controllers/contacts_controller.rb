class ContactsController < ApplicationController
  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]
  
    from_email = SendGrid::Email.new(email: 'no-reply@gtcarpets.uk') # Change this to your sending email
    to_email = SendGrid::Email.new(email: 'gtcarpetsuk@gmail.com') # Change this to the recipient email
    subject = 'New Contact Form Submission'
    content = SendGrid::Content.new(type: 'text/plain', value: "Name: #{name}, Email: #{email}, Message: #{message}")
    
    mail = SendGrid::Mail.new(from_email, subject, to_email, content)
  
    begin
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
    
      # Log the detailed response for troubleshooting
      puts "Response Status Code: #{response.status_code}"
      puts "Response Body: #{response.body}"
      puts "Response Headers: #{response.headers}"
      
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
