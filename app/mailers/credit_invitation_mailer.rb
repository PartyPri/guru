class CreditInvitationMailer < ActionMailer::Base
  default from: "Evrystep@evrystep.com"

  def send_invitation(credit_id:)
    @credit = Credit.includes(:owner, :receiver, :reel).find_by_id(credit_id)
    @receiver = @credit.receiver
    @owner = @credit.owner
    @reel = @credit.reel
    return unless receiver_email
    return unless subject
    mail(to: receiver_email, subject: subject)
  end

  def receiver_email
    @receiver_email ||= (@receiver.try(:email) || @credit.credit_receiver_email)
  end

  def subject
    @subject ||= "#{@owner.try(:first_name)} credited you as a #{@credit.role} on the reel \"#{@reel.name}\" on Evrystep!"
  end
end
