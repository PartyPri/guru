class ClaimUserMailer < ActionMailer::Base
  default from: "foo@bar.com"

  def claim_user
    @token = SecureRandom.hex
    mail(to: 'ccshelton@gmail.com', subject: 'Hello!', tempalte_path: 'claim_user_mailer', template_name: 'claim_email')
  end
end
