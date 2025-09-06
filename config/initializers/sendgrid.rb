require 'sendgrid-ruby'

# Initialize SendGrid
SendGrid::Mail.class_eval do
  def self.defaults(&block)
    @defaults ||= {}
    if block_given?
      yield @defaults
    else
      @defaults
    end
  end
end

SendGrid::Mail.defaults do |mail|
  mail[:from] = { email: 'from@example.com' } # Set the sender's email address
end
