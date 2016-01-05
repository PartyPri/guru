require "spec_helper"

describe Reel do

  describe 'Associations' do
    it { should have_many(:credits) }
  end

  describe '#update_media_added!' do
    subject { create(:reel) }
    let(:now) { Time.now }

    before { Timecop.freeze(Time.local(2015)) }

    it 'updates the media_last_added_at field' do
      expect { subject.update_media_added! }.to change(subject, :media_last_added_at)
    end

    it 'sets the media_last_added_at field to now' do
      subject.update_media_added!
      expect(subject.media_last_added_at).to eq now
    end
  end
end