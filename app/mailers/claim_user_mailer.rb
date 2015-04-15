class ClaimUserMailer < ActionMailer::Base
  default from: "foo@bar.com"

  def claim_user
    @token = SecureRandom.hex(8)
    mail(to: 'foo@bar.com', subject: 'Hello!', tempalte_path: 'claim_user_mailer', template_name: 'claim_email')
  end
end
