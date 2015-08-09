require 'spec_helper'

describe StoriesController, :type => :controller do 

  describe "POST #create" do
    it 'should create a story' do
      story = FactoryGirl.build(:story)
      post :create, post: story
      expect(response.status).to eq(302)
    end
  end

  describe "PUT #update" do
    it 'update it a reel' do
      story = FactoryGirl.create(:story)
      put :update, id: story
      expect(response).to redirect_to(story.reel)
    end
  end

end