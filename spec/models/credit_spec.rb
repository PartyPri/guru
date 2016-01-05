require "spec_helper"

describe Credit do
  describe 'Associations' do
    it { should belong_to(:reel) }
  end
end