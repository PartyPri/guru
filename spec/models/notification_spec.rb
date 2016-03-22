require "spec_helper"

describe Notification do
  describe 'Callbacks' do
    it { is_expected.to callback(:send_notification).after(:create) }
  end

  describe '#action' do
    subject { Notification.new(action: 3) }
    let(:action) { :commented_on }

    it 'returns the action description not the integer' do
      expect(subject.action).to eq action
    end
  end

  describe '#action_taker_avatar_url' do
    subject { Notification.new }
    context 'when the notification as an action taker' do
      let(:action_taker) { create(:user) }
      before { subject.action_taker = action_taker }

      context 'when the action taker as an avatar' do
        let(:url) { "http://some.link.to/something" }
        before { allow(action_taker).to receive(:avatar) { double(url: url) } }

        it 'returns the url' do
          expect(subject.action_taker_avatar_url).to eq url
        end
      end

      context 'when the action taker does not have an avatar' do
        before { allow(action_taker).to receive(:avatar) }

        it 'returns nil' do
          expect(subject.action_taker_avatar_url).to be_nil
        end
      end
    end

    context 'when the notification does not have an action taker' do
      it 'returns nil' do
        expect(subject.action_taker_avatar_url).to be_nil
      end
    end
  end

  describe '#action_happened_at' do
    subject { Notification.create }

    before do
      subject.created_at = 30.days.ago
    end

    it 'returns the created_at time in words' do
      expect(subject.action_happened_at).to eq "about 1 month ago"
    end
  end

  describe '#path_to_action_taken_on' do
    subject { Notification.create(action_taken_on: action_taken_on) }

    context 'when the action_taken_on is a reel' do
      let(:action_taken_on) { create(:reel) }

      it 'returns the path to the reel' do
        expect(subject.path_to_action_taken_on).to end_with "/reels/#{action_taken_on.id}"
      end

      context 'when the notification has a credit_id' do
        context 'when the credit exists' do
          let(:credit) { create(:credit) }
          before { subject.credit_id = credit.id }
          it 'returns the path to the reel with the credit invitation param' do
            expect(subject.path_to_action_taken_on).to include("/reels/#{action_taken_on.id}")
            expect(subject.path_to_action_taken_on).to end_with "?credit_invitation=#{credit.id}"
          end
        end

        context 'when the credit does not exist' do
          before { subject.credit_id = 10000000000000 }
          it 'returns nil' do
            expect(subject.path_to_action_taken_on).to be_nil
          end
        end
      end
    end

    context 'when the action_taken_on is a medium' do
      let(:action_taken_on) { create(:medium, reel_id: 1) }
      let(:path) { "/reels/#{action_taken_on.reel_id}#media-#{action_taken_on.id}" }
      it 'returns the path to the reel' do
        expect(subject.path_to_action_taken_on).to end_with path
      end
    end

    context 'when the action_taken_on is nil' do
      let(:action_taken_on) { nil }

      it 'returns nil' do
        expect(subject.path_to_action_taken_on).to be_nil
      end
    end
  end

  describe '#send_notification' do
    subject { Notification.new }
    let(:delay) { double(send_notification: nil, send_invitation: nil) }

    context 'when the action is sent_credit' do
      before { subject.sent_credit = true }

      it 'sends the credit invitation mailer' do
        expect(CreditInvitationMailer).to receive(:delay) { delay }
        subject.send(:send_notification)
      end

      it 'does not send the notification mailer' do
        expect(NotificationMailer).to_not receive(:delay)
        subject.send(:send_notification)
      end
    end

    context 'when the action is not sent_credit' do
      before { subject.gave_props = true }

      it 'sends the notification mailer' do
        expect(NotificationMailer).to receive(:delay) { delay }
        subject.send(:send_notification)
      end

      it 'does not send the credit invitation mailer' do
        expect(CreditInvitationMailer).to_not receive(:delay)
        subject.send(:send_notification)
      end
    end
  end
end
