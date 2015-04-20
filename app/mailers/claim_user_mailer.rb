class ClaimUserMailer < ActionMailer::Base
  default from: "foo@bar.com"

  def claim_user(email, token)
    @token = token
    @email = email
    mail(to: @email, subject: 'Hello!', tempalte_path: 'claim_user_mailer', template_name: 'claim_email')
  end
end
