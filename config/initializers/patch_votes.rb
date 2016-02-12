module ActsAsVotable
  class Vote

    after_create :notify

    private

    def notify
      # action default is :gave_props
      Notification.create!(
        action_taker: voter,
        action_taken_on: votable,
        receiver: votable.try(:user),
      )
    end
  end
end