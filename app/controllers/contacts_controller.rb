class ContactsController < ApplicationController
  require 'net/http'
  require 'json'

  def create
    # Capture form data
    name = params[:name]
    email = params[:email]
    message = params[:message]
    
    # Validate reCAPTCHA response
    recaptcha_response = params['g-recaptcha-response']
    secret_key = ENV['RECAPTCHA_SECRET_KEY']  # Store your Secret Key in an environment variable

    # Request reCAPTCHA verification
    uri = URI('https://www.google.com/recaptcha/api/siteverify')
    res = Net::HTTP.post_form(uri, {
      'secret' => secret_key,
      'response' => recaptcha_response
    })
    result = JSON.parse(res.body)

    # Check if reCAPTCHA validation is successful
    if result['success']
      # Call your mailer to send the email
      ContactMailer.contact_email(name, email, message).deliver_now

      # Provide feedback to the user
      redirect_to root_path, notice: 'Your message has been sent successfully!'
    else
      # Handle reCAPTCHA failure and redirect to the homepage
      redirect_to root_path, alert: 'Failed to verify reCAPTCHA. Please try again.'
    end
  rescue => e
    # Handle unexpected errors and redirect to the homepage
    redirect_to root_path, alert: 'An error occurred. Please try again later.'
  end
end
