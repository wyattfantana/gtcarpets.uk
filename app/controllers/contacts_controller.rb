class ContactsController < ApplicationController
  def create
    # Assuming params[:contact] contains :name, :email, and :message keys
    # Adjust the parameter keys according to your form data
    name = params[:name]
    email = params[:email]
    message = params[:message]

    # Call your mailer to send the email
    ContactMailer.contact_email(name, email, message).deliver_now

    # Provide feedback to the user
    redirect_to root_path, notice: 'Your message has been sent successfully!'
  rescue => e
    puts "Error sending email: #{e.message}"
    flash.now[:alert] = 'Failed to send email. Please try again later.'
    render :new
  end
end

