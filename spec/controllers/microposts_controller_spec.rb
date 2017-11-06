require 'rails_helper'
require 'spec_helper'

RSpec.describe MicropostsController, type: :controller do

  fixtures :users
  fixtures :microposts

  before do
    @micropost = microposts(:orange)
  end

  describe "microposts controller" do

    it "should redirect create when not logged in" do
      expect{
        post :create, params: { micropost: { content: "Lorem ipsum" } }
      }.to_not change{Micropost.count}
      expect(response).to redirect_to(login_url)
    end

    it "should redirect destroy when not logged in" do
      expect{
        delete :destroy, params: { id: @micropost.id }
      }.to_not change{Micropost.count}
      expect(response).to redirect_to(login_url)
    end

    it "should redirect destroy for wrong micropost" do
      log_in_as(users(:michael))
      micropost = microposts(:ants)
      expect{
        delete :destroy, params: { id: micropost.id }
      }.to_not change{Micropost.count}
      expect(response).to redirect_to(root_url)
    end

  end
end
