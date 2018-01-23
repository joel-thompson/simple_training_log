require 'rails_helper'

RSpec.describe LiftCalculationsController, type: :controller do



  before do

  end

  describe '#index' do
    it "redirects to login if not logged in" do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

end
