# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Guru::Application.initialize!

# Configure Action Mailer
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASS'],
  :domain => 'evrystep.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
