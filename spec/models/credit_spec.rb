require "spec_helper"

describe Credit do
  describe 'Associations' do
    it { should belong_to(:reel) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:reel_id) }
    it { should validate_presence_of(:reel_owner_id) }
  end

  describe 'Callbacks' do
    describe 'before_validation' do
      context 'set_default_role' do
        let(:credit) { described_class.new }
        it 'sets the default role' do
          expect { credit.valid? }.to change(credit, :role).from(nil).to(described_class::DEFAULT_ROLE)
        end
      end

      context 'set_reel_owner' do
        let(:credit) { Credit.new(reel_id: reel.id) }
        let(:reel) { create(:reel) }
        it 'sets the reel_owner_id when there is none' do
          expect { credit.valid? }.to change(credit, :reel_owner_id).from(nil).to(reel.user_id)
        end
      end

      context 'set_credit_receiver_email' do
        let(:credit) { Credit.new(credit_receiver_id: user.id) }
        let(:user) { create(:user) }
        it 'sets the credit_receiver_email when there is none' do
          expect { credit.valid? }.to change(credit, :credit_receiver_email).from(nil).to(user.email)
        end
      end

      context 'set_credit_receiver_id' do
        let(:credit) { Credit.new(credit_receiver_email: user.email) }
        let(:user) { create(:user) }
        it 'sets the credit_receiver_email when there is none' do
          expect { credit.valid? }.to change(credit, :credit_receiver_id).from(nil).to(user.id)
        end
      end
    end

    describe 'after_save' do
      it { should callback(:notify_acceptance).after(:save) }
      it { should callback(:notify_creation).after(:save) }

      context 'on create' do
        it 'should notify_creation when pending' do
          credit = build(:credit)
          expect { credit.save }.to change(Notification.sent_credit, :count).by(1)
        end

        it 'should not notify_creation when already accepted' do
          credit = build(:credit)
          credit.accepted = true
          expect { credit.save }.to_not change(Notification.sent_credit, :count)
        end

        it 'should not notify_creation when already rejected' do
          credit = build(:credit)
          credit.accepted = true
          expect { credit.save }.to_not change(Notification.sent_credit, :count)
        end
      end

      context 'on update' do
        it 'should not notify_creation when rejected' do
          credit = create(:credit)
          credit.rejected = true
          expect { credit.save }.to_not change(Notification.sent_credit, :count)
        end

        it 'should not notify_creation when accepted' do
          credit = create(:credit)
          credit.accepted = true
          expect { credit.save }.to_not change(Notification.sent_credit, :count)
        end

        it 'should notify_acceptance' do
          credit = create(:credit)
          credit.accepted = true
          expect { credit.save }.to change(Notification.accepted_credit_invite, :count).by(1)
        end
      end
    end

    it { is_expected.to callback(:destroy_notifications).before(:destroy) }
  end

  describe 'notify_acceptance' do
    subject { build(:credit) }

    context 'when the invitation_status has not changed' do
      it 'does not create a new notification' do
        expect do
          subject.send(:notify_acceptance)
        end.to_not change(Notification, :count)
      end
    end

    context 'when the invitation_status has changed' do
      context 'when the invitation_status has change to accepted' do
        before { subject.accepted = true }

        it 'creates a new notification' do
          expect do
            subject.send(:notify_acceptance)
          end.to change(Notification, :count).by(1)
        end

        context 'notification' do
          let!(:notification) { subject.send(:notify_acceptance) }

          it 'sets the correct action_taker' do
            expect(notification.action_taker_id).to eq subject.credit_receiver_id
          end

          it 'sets the correct receiver' do
            expect(notification.receiver_id).to eq subject.reel_owner_id
          end

          it 'sets the correct action' do
            expect(notification.action).to eq :accepted_credit_invite
          end

          it 'sets the correct action_taken_on' do
            expect(notification.action_taken_on_id).to eq subject.reel_id
            expect(notification.action_taken_on_type).to eq "Reel"
          end
        end
      end

      context 'when the invitation_status has changed to not accepted' do
        before { subject.rejected = true }
        it 'does not create a new notification' do
          expect do
            subject.send(:notify_acceptance)
          end.to_not change(Notification, :count)
        end
      end
    end
  end

  describe 'notify_creation' do
    subject { build(:credit) }

    before { allow(subject).to receive(:id_changed?) { true } }

    it 'creates a new notification' do
      expect do
        subject.send(:notify_creation)
      end.to change(Notification, :count).by(1)
    end

    context 'notification' do
      let!(:notification) { subject.send(:notify_creation) }

      it 'sets the correct action_taker' do
        expect(notification.action_taker_id).to eq subject.reel_owner_id
      end

      it 'sets the correct receiver' do
        expect(notification.receiver_id).to eq subject.credit_receiver_id
      end

      it 'sets the correct action' do
        expect(notification.action).to eq :sent_credit
      end

      it 'sets the correct action_taken_on' do
        expect(notification.action_taken_on_id).to eq subject.reel_id
        expect(notification.action_taken_on_type).to eq "Reel"
      end
    end
  end

  describe 'destroy_notifications' do
    it 'destroys the associated notifications' do
      credit = create(:credit)
      expect { credit.send(:destroy_notifications) }.to change(Notification, :count).by(-1)
    end
  end
end
