require "spec_helper"

describe Comments::NotifyWorker do
  describe '.perform' do
    let(:action_taker) { create(:user) }
    let(:medium) { create(:medium) }
    let(:args) do
      {
        commentable_id: medium.id,
        commentable_type: medium.class.base_class.name,
        action_taker_id: action_taker.id,
        action: :something
      }
    end
    subject { described_class.perform(args) }

    describe 'when there are multiple users who commented on a medium' do
      let(:users) { (0..2).map { create(:user) } }
      let(:comments) { users.map {|u| Comment.create(user: u, commentable: medium, body: "hi") } }


      it 'creates a notification for each one' do
        expect { subject }.to change(Notification, :count).by(comments.count)

        users.each do |u|
          expect(Notification.find_by_receiver_id(u.id)).to_not be_nil
        end
      end

      context 'the notifications are created correctly' do
        before { comments && subject }

        it 'creates a notification with the correct action_taken_on' do
          expect(Notification.last.action_taken_on).to eq medium
        end

        it 'creates a notification with the correct action_taker' do
          expect(Notification.last.action_taker).to eq action_taker
        end
      end
    end

    describe 'when a user has commented multiple times on a medium' do
      let(:users) { (0..2).map { create(:user) } }
      let(:comments) do
        a = users.map {|u| Comment.create(user: u, commentable: medium, body: "hi") }
        a << Comment.create(user: users.last, commentable: medium, body: "hi")
      end

      before { comments && subject }

      it 'creates only one notification for each user' do
        users.each do |u|
          expect(Notification.where(receiver_id: u.id).count).to eq 1
        end
      end
    end
  end
end