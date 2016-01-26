require "spec_helper"

describe UsersController, type: :controller do
  describe 'GET show' do
    let(:user) { create(:user) }
    subject { get :show, id: user.id }

    context 'when the user id is found' do
      it 'renders the show view' do
        subject
        expect(response).to render_template(:show)
      end

      it 'sets the users instance var to the found user' do
        subject
        expect(assigns(:user)).to eq user
      end

      context 'when the user has interests' do
        let(:interest) { create(:interest) }
        before { user.interests << interest }

        it 'sets the interests instance var to the associated interests' do
          subject
          expect(assigns(:interests)).to eq([interest])
        end
      end

      context 'when the user has reels' do
        before do
          [10, 1].map do |i|
            create(:reel, user_id: user.id, media_last_added_at: i.days.ago)
          end
        end

        let(:sorted_reels) { Reel.order("media_last_added_at desc").map(&:media_last_added_at) }

        it 'sets the instance var' do
          subject
          expect(assigns(:reels)).not_to be_nil
        end

        it 'orders the reels by media_last_added_at' do
          subject
          expect(assigns(:reels).map(&:media_last_added_at)).to eq sorted_reels
        end
      end
    end

    context 'when the user id is not found' do
      subject { get :show, id: 0 }
      it 'redirects to root' do
        expect(subject).to redirect_to(:root)
      end
    end
  end
end
