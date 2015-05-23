require 'spec_helper'

describe ReelsController, :type => :controller do  
 
  describe "GET #show" do
    reel = FactoryGirl.create(:reel)

    it 'should find a reel' do
      reel = Reel.where(name: 'Foo Reel')
      expect(reel).to exist
    end
  end

  describe "GET #create" do
    reel = FactoryGirl.create(:reel)
    
    it 'should create a reel' do
      post :create, post: reel
      expect(response.status).to eq(302)
    end
  end

  describe "PUT #update" do
    it 'update a reel' do
      reel = FactoryGirl.create(:reel)
      put :update, id: reel
      expect(response).to redirect_to(reel)
    end
  end

end