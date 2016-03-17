require "spec_helper"

describe Medium do
  describe 'Validations' do
    it { should validate_presence_of(:reel_id) }
  end

  describe 'Callbacks' do
    it { is_expected.to callback(:destroy_notifications).before(:destroy) }
    it { is_expected.to callback(:update_reel_media_added).after(:save) }
  end

  describe '#update_reel_media_added' do
    subject { create(:medium, reel_id: reel_id) }

    context 'when there is an associated reel' do
      let(:reel) { create(:reel) }
      let(:reel_id) { reel.id }

      it 'updates the media_last_added_at field on the reel' do
        subject.update_reel_media_added
        expect(reel.reload.media_last_added_at).not_to be_nil
      end
    end

    context 'when there is not an associated reel' do
      let(:reel_id) { 0 }
      it 'does nothing' do
        expect(subject.update_reel_media_added).to eq nil
      end
    end
  end
end