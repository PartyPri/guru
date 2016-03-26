module Comments
  class NotifyWorker
    def self.perform(args)
      new(args).perform
    end

    attr_reader :args

    def initialize(args)
      @args = args
    end

    def comments
      Comment.where(args.slice(:commentable_id, :commentable_type))
        .group(:user_id)
        .select(:user_id)
    end

    def perform
      comments.each do |comment|
        Notification.create(
          action_taken_on_id: args[:commentable_id],
          action_taken_on_type: args[:commentable_type],
          action_taker_id: args[:action_taker_id],
          action: args[:action],
          receiver_id: comment.user_id
        )
      end
    end
  end
end