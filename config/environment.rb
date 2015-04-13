# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Guru::Application.initialize!

# Configure Action Mailer 
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'mail.google.com',
  :port           => 587,
  :user_name      => ENV['ACTION_MAILER_USERNAME'],
  :password       => ENV['ACTION_MAILER_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}
