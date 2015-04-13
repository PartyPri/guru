class ClaimUserMailer < ActionMailer::Base
  default from: "ccshelton@gmail.com"

  def claim_user
    mail(to: 'ccshelton@gmail.com', subject: 'Hello!', tempalte_path: 'claim_user_mailer', template_name: 'claim_email')
  end
end
