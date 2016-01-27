require "spec_helper"

describe Credit do
  describe 'Associations' do
    it { should belong_to(:reel) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:credit_receiver_email) }
    it { should validate_presence_of(:reel_id) }
    it { should validate_presence_of(:reel_owner_id) }
  end

  describe 'Callbacks' do
    describe 'before_validation' do
      let(:credit) { described_class.new }
      it 'sets the default role' do
        expect { credit.valid? }.to change(credit, :role).from(nil).to(described_class::DEFAULT_ROLE)
      end
    end
  end
end
