require "spec_helper"

describe CreditsController, type: :controller do
  let!(:reel) { create(:reel, user_id: reel_owner.id) }
  let(:reel_owner) { create(:user) }
  let(:credit_receiver) { create(:user) }

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
          let(:mailer) { double(:mailer) }

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

          it 'delivers the invitation email' do
            expect(CreditInvitationMailer).to receive(:send_invitation) {mailer}
            expect(mailer).to receive(:deliver)
            subject
          end

          context 'when the mailer errors' do
            before { allow_any_instance_of(CreditInvitationMailer).to receive(:send_invitation) { raise_error } }

            it 'logs the error' do
              expect(Rails.logger).to receive(:error)
              subject
            end
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

  describe 'PUT respond_to_invitation' do
    subject { put :respond_to_invitation, params }
    let(:params) { {reel_id: reel.id, id: credit_id} }
    let(:credit_id) { 0 }

    context 'when a user is signed in' do
      before { sign_in(credit_receiver) }

      context 'when the credit is found' do
        let(:credit) { create(:credit, reel_id: reel.id) }
        let(:credit_id) { credit.id }

        context 'when the credit saves successfully' do
          it 'redirects to reel show' do
            expect(subject).to redirect_to(reel_url(reel))
          end

          it 'shows the correct flash notice' do
            subject
            expect(flash[:notice]).to eq "Credit accepted"
          end
        end

        context 'when the credit does not save successfully' do
          before { allow_any_instance_of(Credit).to receive(:save) { false } }

          it 'redirects to root' do
            expect(subject).to redirect_to(reel_url(reel))
          end

          it 'shows the correct flash notice' do
            subject
            expect(flash[:notice]).to eq described_class::GENERAL_ERROR
          end
        end
      end

      context 'when the credit is not found' do
        it 'redirects to reel show' do
          expect(subject).to redirect_to(reel_url(reel))
        end

        it 'shows the correct flash notice' do
          subject
          expect(flash[:notice]).to eq described_class::NOT_FOUND_NOTICE
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to reel show' do
        expect(subject).to redirect_to(reel_url(reel))
      end

      it 'shows the correct flash notice' do
        subject
        expect(flash[:notice]).to eq described_class::AUTH_NOTICE
      end
    end
  end
end