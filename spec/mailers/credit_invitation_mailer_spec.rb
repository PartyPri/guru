require "spec_helper"

describe CreditInvitationMailer, :type => :mailer do
  describe '#send_invitation' do
    subject { described_class }

    context 'when the credit is found' do
      let(:credit) do
        user = create(:user)
        reel = create(:reel, user_id: user.id)
        create(:credit, reel_id: reel.id, reel_owner_id: user.id)
      end

      let(:execute) { subject.send_invitation(credit_id: credit.id) }

      context 'when the credit does not have a receiver_email' do
        before { credit.update_column(:credit_receiver_email, nil) }

        it 'raises an error' do
          expect { execute }.to raise_error(CreditInvitationMailer::Error, "Receiver email cannot be blank")
        end
      end

      context 'when the credit does not have an owner' do
        before { credit.update_column(:reel_owner_id, nil) }

        it 'raises an error' do
          expect { execute }.to raise_error(CreditInvitationMailer::Error, "Owner cannot be blank")
        end
      end

      context 'when the credit does not have a reel' do
        before { credit.update_column(:reel_id, nil) }

        it 'raises an error' do
          expect { execute }.to raise_error(CreditInvitationMailer::Error, "Reel cannot be blank")
        end
      end

      context 'when the credit is valid' do
        it 'generates a mail message' do
          expect(execute).to be_a_kind_of(Mail::Message)
        end

        it 'to is correct' do
          expect(execute.to).to include(credit.credit_receiver_email)
        end

        it 'subject includes owner' do
          expect(execute.subject).to include(credit.owner.first_name)
        end

        it 'subject includes reel' do
          expect(execute.subject).to include(credit.reel.name)
        end

        it 'subject includes role' do
          expect(execute.subject).to include(credit.role)
        end
      end
    end

    context 'when the credit is not found' do
      let(:execute) { subject.send_invitation(credit_id: 0) }
      it 'raises an error' do
        expect { execute }.to raise_error(CreditInvitationMailer::Error, "Credit not found")
      end
    end
  end
end