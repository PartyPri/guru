require 'spec_helper'

describe ReelsController, :type => :controller do  
 
  let!(:reel) {build(:reel) }

  describe "GET #create" do
    
    it 'should create a reel' do
      post :create, post: reel
      expect(response.status).to eq(302)
    end
  end

  describe "GET #show" do

    it 'should find a reel' do
      reel.save
      found_reel = Reel.where(name: 'Foo Reel')
      expect(found_reel).to exist
    end
  end
end