class ChangeAcceptedInvitationOnCredits < ActiveRecord::Migration
  def change
    remove_column :credits, :accepted_invitation
    add_column :credits, :invitation_status, :integer, default: 0
  end
end
