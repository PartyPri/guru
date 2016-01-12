require "spec_helper"

describe Credit do
  describe 'Associations' do
    it { should belong_to(:reel) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:credit_receiver_email) }
    it { should validate_presence_of(:reel_id) }
    it { should validate_presence_of(:reel_owner_id) }
    it { should validate_presence_of(:role) }
  end
end