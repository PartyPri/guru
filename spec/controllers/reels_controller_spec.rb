require 'spec_helper'

describe ReelsController, :type => :controller do

  let!(:reel) {create(:reel) }

  describe "GET #create" do

    it 'should create a reel' do
      post :create, post: reel
      expect(response.status).to eq(302)
    end
  end

  describe "PUT #update" do
    it 'update a reel' do
      put :update, id: reel.id
      expect(response).to redirect_to(reel)
    end
  end

  describe "GET #show" do

    it 'should find a reel' do
      found_reel = Reel.where(name: 'Foo Reel')
      expect(found_reel).to exist
    end
  end
end
