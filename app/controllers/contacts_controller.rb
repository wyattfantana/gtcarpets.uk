class ContactsController < ApplicationController
  require 'net/http'
  require 'json'
  
  # Rate limiting: Store submission times in session
  before_action :check_rate_limit

  def create
    # Capture form data
    name = params[:name]
    email = params[:email]
    message = params[:message]
    
    # Anti-spam validations
    return redirect_to_home_with_error('Invalid submission detected.') unless valid_submission?
    
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
      # Update rate limiting tracker
      update_submission_tracker
      
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
  
  private
  
  def valid_submission?
    # 1. Honeypot validation - hidden field should be empty
    return false if params[:website].present?
    
    # 2. Time-based validation - form should take at least 3 seconds to fill
    form_start_time = params[:form_timestamp].to_i
    return false if form_start_time == 0 || (Time.current.to_i - form_start_time) < 3
    
    # 3. Content length validation
    return false if params[:name].to_s.length > 100
    return false if params[:email].to_s.length > 100
    return false if params[:message].to_s.length > 2000
    return false if params[:message].to_s.length < 10
    
    # 4. Basic spam keyword detection
    spam_keywords = ['viagra', 'casino', 'lottery', 'winner', 'congratulations', 'click here', 'free money', 'make money fast', 'bitcoin', 'cryptocurrency', 'invest now', 'guaranteed profit']
    message_lower = params[:message].to_s.downcase
    return false if spam_keywords.any? { |keyword| message_lower.include?(keyword) }
    
    # 5. Check for excessive links
    link_count = params[:message].to_s.scan(/https?:\/\//).count
    return false if link_count > 2
    
    # 6. Email validation
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    return false unless params[:email].to_s.match?(email_regex)
    
    true
  end
  
  def check_rate_limit
    # Initialize submission tracker if not exists
    session[:contact_submissions] ||= []
    
    # Clean old submissions (older than 1 hour)
    session[:contact_submissions].reject! { |time| time < 1.hour.ago.to_i }
    
    # Check if too many submissions in the last hour (max 3)
    if session[:contact_submissions].count >= 3
      redirect_to_home_with_error('Too many submissions. Please wait before trying again.')
      return
    end
    
    # Check if submission too soon after last one (min 30 seconds)
    if session[:contact_submissions].any? && (Time.current.to_i - session[:contact_submissions].last) < 30
      redirect_to_home_with_error('Please wait before submitting again.')
      return
    end
  end
  
  def update_submission_tracker
    session[:contact_submissions] ||= []
    session[:contact_submissions] << Time.current.to_i
  end
  
  def redirect_to_home_with_error(message)
    redirect_to root_path, alert: message
  end
end
