require 'spec_helper'

describe User do
  context "instance methods" do
    describe "token_expired?" do
      let (:user) {build(:user)}
      it "returns true if the expires_at field is before now" do
        user.expires_at = Time.now - 5.hours
        expect(user.token_expired?).to eq true
      end

      it "returns false if the expires_at field is after now" do
        user.expires_at = Time.now + 5.hours
        expect(user.token_expired?).to eq false
      end
    end

    describe "followed_users" do
      # TODO but see note to refactor at method declaration
    end
  end

  context "class methods" do
    describe "find_for_google_oauth2" do
      # TODO
    end
  end
end
