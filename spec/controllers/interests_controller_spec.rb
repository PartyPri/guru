require 'spec_helper'

describe InterestsController, type: :controller do

  let(:interest) { create(:interest) }

  describe "#show" do
    context 'when the interest is found' do
      before { get :show, id: interest.id }

      it 'finds an interest to show' do
        expect(assigns(:interest)).to eq interest
      end

      it 'renders the correct view' do
        expect(response).to render_template(:show)
      end

      context 'when the interest has followers' do
        let!(:user) { create(:user, interest_ids: [interest.id]) }

        it 'sets the followers variable to the associated users' do
          expect(assigns(:followers)).to eq [user]
        end
      end

      context 'when the interest has no followers' do
        it 'sets the followers variable to an empty array' do
          expect(assigns(:followers)).to be_empty
        end
      end

      context 'when the interest has associated reels' do
        let!(:reel) { create(:reel, interest_ids: [interest.id]) }

        context 'when the reels have media associated' do
          let!(:media) { (1..max).map { create(:medium, reel_id: reel.id) } }
          context 'when the reels have more than 2 pieces of media' do
            let(:max) { 3 }
            it 'sets the reels variable to the reel' do
              expect(assigns(:reels)).to eq [reel]
            end

            context 'when there is more than one reel' do
              let!(:reel_2) { create(:reel, interest_ids: [interest.id]) }
              let!(:reel_2_media) { (1..max).map { create(:medium, reel_id: reel_2.id) } }
              let(:sorted_reels) { [reel_2, reel].sort_by {|x| x.reload.media_last_added_at}.reverse }

              it 'sets the reels variable with the array of reels sorted by media_last_added_at desc' do
                expect(assigns(:reels)).to eq sorted_reels
              end
            end
          end

          context 'when the reels have 2 or less pieces of media' do
            let(:max) { 2 }
            it 'sets the reels variable to an empty array' do
              expect(assigns(:reels)).to be_empty
            end
          end
        end

        # context 'when the reels have tags associated to them' do
        #   let!(:reel) { create(:reel, interest_ids: [interest.id], tag_list: ["dance"]) }
        #
        #   it 'sets the tags variable to a list of associated tags' do
        #     expect(assigns(:tags)).to match_array reel.tags
        #   end
        # end

        context 'when the reels have no tags assigns to them' do
          it 'sets the tags variable to an empty array' do
            expect(assigns(:tags)).to be_empty
          end
        end
      end
    end

    context 'when the interest is not found' do
      before { get :show, id: (interest.id - 10) }

      it 'redirects to root' do
        expect(response).to redirect_to :root
      end
    end
  end
end
