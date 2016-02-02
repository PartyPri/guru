class CreditInvitationMailer < ActionMailer::Base
  default from: "Evrystep@evrystep.com"

  class CreditInvitationMailerError < StandardError
    def initialize(message)
      super(message)
    end
  end

  def send_invitation(credit_id:)
    self.credit = credit_id
    validate!
    mail(to: receiver_email, subject: subject)
  end

  def validate!
    raise CreditInvitationMailerError.new("Receiver email cannot be blank") unless receiver_email
    raise CreditInvitationMailerError.new("Owner cannot be blank") unless owner
    raise CreditInvitationMailerError.new("Reel cannot be blank") unless reel
  end

  def receiver_email
    @receiver_email ||= (receiver.try(:email) || credit.credit_receiver_email)
  end

  def credit
    @credit
  end

  def credit=(credit_id)
    @credit = Credit.includes(:owner, :receiver, :reel).find_by_id(credit_id)
  end

  def subject
    @subject ||= "#{owner.try(:first_name)} credited you as a #{credit.role} on the reel \"#{reel.name}\" on Evrystep!"
  end

  def receiver
    @receiver ||= @credit.receiver
  end

  def owner
    @owner ||= @credit.owner
  end

  def reel
    @reel ||= @credit.reel
  end
end
