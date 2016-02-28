require "spec_helper"

describe NotificationsController, type: :controller do
  describe 'PUT update' do
    context 'when the user is signed in' do
      let(:receiver) { create(:user) }
      before { sign_in(receiver) }

      context 'when the notification is found' do
        let(:notification) { create(:notification, receiver: receiver) }
        subject { put(:update, id: notification.id) }

        context 'when the notification saved' do
          before { allow_any_instance_of(Notification).to receive(:save) { true } }

          it 'returns 200' do
            subject
            expect(response.status).to eq 200
          end
        end

        context 'when the notification is not saved' do
          before { allow_any_instance_of(Notification).to receive(:save) { false } }
          it 'returns 422' do
            subject
            expect(response.status).to eq 422
          end
        end
      end

      context 'when the notification is not found' do
        subject { put :update, id: 0 }
        it 'returns 404' do
          subject
          expect(response.status).to eq 404
        end
      end
    end

    context 'when the user is not signed in' do

    end

  end
end