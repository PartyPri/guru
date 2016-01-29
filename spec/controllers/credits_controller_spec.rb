require "spec_helper"

describe CreditsController, type: :controller do
  let!(:reel) { create(:reel, user_id: reel_owner.id) }
  let(:reel_owner) { create(:user) }
  let(:credit_receiver) { create(:user) }

  describe 'GET index' do

    it 'assigns a reel instance var' do
      get :index, reel_id: reel.id
      expect(assigns(:reel)).to eq reel
    end

    it 'includes the credits' do
      Bullet.enable = false
      expect(Reel).to receive(:includes).with(:credits).and_call_original
      get :index, reel_id: reel.id
      Bullet.enable = true
    end

    context 'when the reel has credits' do
      let(:credit_params) do
        {
          credit_receiver_email: credit_receiver.email,
          reel_id: reel.id,
          reel_owner_id: reel.user_id,
          role: "inspiration"
        }
      end

      let!(:credit) { Credit.create!(credit_params) }

      it 'assigns a credits instance var' do
        get :index, reel_id: reel.id
        expect(assigns(:credits)).to eq [credit]
      end
    end
  end

  describe 'GET new' do
    subject { get :new, reel_id: reel.id }

    context 'when a user is not signed in' do
      it 'redirects to root' do
        expect(subject).to redirect_to(:root)
      end

      it 'sets a flash notice explaning the error' do
        subject
        expect(flash[:notice]).to eq described_class::AUTH_NOTICE
      end
    end

    context 'when a user is signed in' do
      context 'when the user is reel owner' do

        before do
          sign_in(reel_owner)
          subject
        end

        it 'renders the new view' do
          expect(response).to render_template(:new)
        end

        it 'assigns the reel instance var' do
          expect(assigns(:reel)).to eq reel
        end
      end

      context 'when the user is not the reel owner' do
        before { sign_in(credit_receiver) }
        it 'redirects to root' do
          expect(subject).to redirect_to(:root)
        end

        it 'sets a flash notice explaning the error' do
          subject
          expect(flash[:notice]).to eq described_class::PERMISSION_NOTICE
        end
      end
    end
  end

  describe 'POST create' do
    subject { post :create, params }
    let(:params) { {reel_id: reel.id}.merge(addtl_params) }
    let(:addtl_params) { {} }

    context 'when a user is not signed in' do
      it 'redirects to root' do
        expect(subject).to redirect_to(:root)
      end

      it 'sets a flash notice explaning the error' do
        subject
        expect(flash[:notice]).to eq described_class::AUTH_NOTICE
      end
    end

    context 'when a user is signed in' do
      context 'when the user is reel owner' do
        before { sign_in(reel_owner) }
        context 'when all necessary params are passed in' do
          let(:addtl_params) do
            {
              credit: {
                credit_receiver_email: credit_receiver.email,
                role: "Some Role"
              }
            }
          end
          let(:saved_credit) { reel.reload.credits.last }

          it 'saves a credit' do
            expect { subject }.to change(Credit, :count).by(1)
          end

          context 'credit info' do
            before { subject }

            it 'has the correct receiver email' do
              expect(saved_credit.credit_receiver_email).to eq credit_receiver.email
            end

            it 'has the correct reel_owner' do
              expect(saved_credit.reel_owner_id).to eq reel_owner.id
            end

            it 'has the correct role' do
              expect(saved_credit.role).to eq params[:credit][:role]
            end

            it 'has the correct credit_receiver_id' do
              expect(saved_credit.credit_receiver_id).to eq credit_receiver.id
            end

            it 'has the correct reel_id' do
              expect(saved_credit.reel_id).to eq reel.id
            end
          end

          it 'redirects to reel show' do
            expect(subject).to redirect_to(reel_url(reel))
          end

          it 'has a correct flash notice' do
            subject
            expect(flash[:notice]).to eq described_class::ADDED_NOTICE
          end
        end

        context 'when params are missing' do
          let(:addtl_params) { {credit: {}} }

          it 'renders new' do
            subject
            expect(response).to render_template(:new)
          end

          it 'does not save a credit' do
            expect { subject }.not_to change(Credit, :count)
          end
        end
      end

      context 'when the user is not the reel owner' do
        before { sign_in(credit_receiver) }
        it 'redirects to root' do
          expect(subject).to redirect_to(:root)
        end

        it 'sets a flash notice explaning the error' do
          subject
          expect(flash[:notice]).to eq described_class::PERMISSION_NOTICE
        end
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params }
    let(:params) { {reel_id: reel.id, id: credit.id} }
    let(:credit) { double(id: 1) }

    context 'when a user is not signed in' do
      it 'redirects to root' do
        expect(subject).to redirect_to(:root)
      end

      it 'sets a flash notice explaning the error' do
        subject
        expect(flash[:notice]).to eq described_class::AUTH_NOTICE
      end
    end

    context 'when a user is signed in' do
      context 'when the user is reel owner' do
        before { sign_in(reel_owner) }

        context 'when the credit is found' do
          let(:credit) { create(:credit, reel_id: reel.id, reel_owner_id: reel_owner.id) }

          context 'when the credit is destroyed' do
            it 'removes the credit from the DB' do
              subject
              expect(Credit.find_by_id(credit.id)).to be_nil
            end

            it 'redirects to reel show' do
              expect(subject).to redirect_to(reel_url(reel))
            end

            it 'shows a deleted flash message' do
              subject
              expect(flash[:notice]).to eq described_class::DELETED_NOTICE
            end
          end

          context 'when the credit is not destroyed' do
            before { allow_any_instance_of(Credit).to receive(:destroy) }

            it 'still has the credit in the DB' do
              subject
              expect(Credit.find_by_id(credit.id)).not_to be_nil
            end

            it 'redirects to reel show' do
              expect(subject).to redirect_to(reel_url(reel))
            end

            it 'shows an error flash message' do
              subject
              expect(flash[:notice]).to eq described_class::GENERAL_ERROR
            end
          end
        end

        context 'when the credit is not found' do
          let(:credit) { create(:credit, reel_id: 0, reel_owner_id: reel_owner.id) }

          it 'redirects to reel show' do
            expect(subject).to redirect_to(reel_url(reel))
          end

          it 'has a not found flash message' do
            subject
            expect(flash[:notice]).to eq described_class::NOT_FOUND_NOTICE
          end
        end
      end

      context 'when the user is not the reel owner' do
        before { sign_in(credit_receiver) }
        it 'redirects to root' do
          expect(subject).to redirect_to(:root)
        end

        it 'sets a flash notice explaning the error' do
          subject
          expect(flash[:notice]).to eq described_class::PERMISSION_NOTICE
        end
      end
    end
  end
end