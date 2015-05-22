require 'spec_helper'

describe ArticlesController, :type => :controller do 

  describe "POST #create" do
    it 'should create an article' do
      article = FactoryGirl.create(:article)
      post :create, post: article
      expect(response.status).to eq(302)
    end
  end

  describe "PUT #update" do
    it 'update it a reel' do
      article = FactoryGirl.create(:article)
      put :update, id: article
      expect(response).to redirect_to(article.reel)
    end
  end

end