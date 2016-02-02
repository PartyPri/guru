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
  end
end
