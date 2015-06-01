require 'spec_helper'

describe InterestsController, :type => :controller do 

  let!(:interest){create(:interest)}
  
  describe "interests #show" do
    it 'finds an interest to show' do
      gotten_interest = Interest.where(name: 'Waacking')
      expect(gotten_interest).to exist
    end

    it 'redirects to root if interest is blank' do
      gotten_interest = Interest.where(name: 'Foobar')
      get :show, id: gotten_interest
      expect(gotten_interest).to be_blank
      expect(response).to redirect_to :root
    end
  end
end
