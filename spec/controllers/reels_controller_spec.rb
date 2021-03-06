require 'spec_helper'

describe ReelsController, :type => :controller do

  let!(:reel) { create(:reel) }

  describe "GET #create" do
    it 'should create a reel' do
      post :create, post: reel
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #new' do
    let!(:interests) { create(:interest) }
    it 'assigns an interests instance var' do
      get :new
      expect(assigns(:interests)).to eq [interests]
    end
  end

  describe 'GET #edit' do
    let!(:interests) { create(:interest) }
    it 'assigns an interests instance var' do
      get :edit, id: reel.id
      expect(assigns(:interests)).to eq [interests]
    end
  end

  describe "PUT #update" do
    it 'update a reel' do
      put :update, id: reel.id
      expect(response).to redirect_to(reel)
    end
  end

  describe "GET #show" do
    context 'when there is a credit_invitation param' do
      subject { get :show, params }
      let(:reel) { create(:reel) }
      let(:params) { {id: reel.id, credit_invitation: credit_id} }

      context 'when there is a credit found' do
        let(:credit) { create(:credit) }
        let(:credit_id) { credit.id }
        context 'when there is a user signed in' do
          let(:credit_receiver) { create(:user) }
          before { sign_in(credit_receiver) }

          context 'when the credit is pending' do
            before { credit.update_attributes(pending: true) }
            it 'sets the credit instance var' do
              subject
              expect(assigns(:pending_credit)).to eq credit
            end
          end

          context 'when the credit is not pending' do
            before { credit.update_attributes(accepted: true) }

            it 'does not set the credit instance var' do
              subject
              expect(assigns(:pending_credit)).to be_nil
            end
          end
        end

        context 'when there is not a user signed in' do
          it 'does not set the credit instance var' do
            subject
            expect(assigns(:pending_credit)).to eq credit
          end
        end
      end

      context 'when the credit is not found' do
        let(:credit_id) { 0 }
        it 'does not set the credit instance var' do
          subject
          expect(assigns(:pending_credit)).to be_nil
        end
      end
    end

    context 'when a reel is found' do
      let(:reel) { create(:reel) }
      subject { get :show, id: reel.id }

      it 'renders the show view' do
        subject
        expect(response).to render_template(:show)
      end

      it 'assigns the user instance var' do
        subject
        expect(assigns(:user)).to eq reel.user
      end

      context 'when the reel has credits' do
        let(:credit) { create(:credit, invitation_status: 1) }
        before { reel.credits << credit }

        it 'assigns the credit instance var' do
          subject
          expect(assigns(:credits)).to eq [credit]
        end
      end
    end

    context "when a reel is not found" do
      subject { get :show, id: 0 }

      it 'redirect_to root' do
        expect(subject).to redirect_to(:root)
      end

      it 'sets the correct flash notice' do
        subject
        expect(flash[:notice]).to eq described_class::NOT_FOUND_NOTICE
      end
    end
  end
end
