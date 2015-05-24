require 'spec_helper'

describe InterestsController, :type => :controller do 
  FactoryGirl.create(:interest) 
  
  describe "interests #show" do
    it 'finds an interest to show' do
      interest = Interest.where(name: 'Waacking')
      expect(interest).to exist
    end

    it 'redirects to root if interest is blank' do
      interest = Interest.where(name: 'Foobar')
      get :show, id: interest
      expect(interest).to be_blank
      expect(response).to redirect_to :root
    end
  end

end