require 'rails_helper'
require 'spec_helper'

RSpec.describe MartialArts::MartialArtsController, type: :controller do

  fixtures :users
  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  let(:user) { users(:martial_artist) }
  let(:other_user) { users(:archer) }

  let(:martial_art_saved) { martial_arts(:base) }

  describe "Martial Arts Controller" do

    it "redirects to homepage on index if logged in" do
      log_in_as user
      get :index
      expect(response).to redirect_to(root_url)
    end

    it "redirects to login if logged out" do
      get :index
      expect(response).to redirect_to(login_url)
    end


    it "redirects to root on edit when not correct user" do
      log_in_as other_user
      get :edit, params: { id: martial_art_saved.id }
      expect(response).to redirect_to(root_url)
    end

    it "redirects to root on update when not correct user" do
      log_in_as other_user
      put :update, params: {
        id: martial_art_saved.id,
        martial_art: {
          notes: "foo"
        }
      }
      expect(martial_art_saved.reload.notes).to_not eq("foo")
      expect(response).to redirect_to(root_url)
    end

    it "redirects to root on destroy when not correct user" do
      log_in_as other_user
      expect{
        delete :destroy, params: { id: martial_art_saved.id }
      }.to_not change{MartialArts::MartialArt.count}
      expect(response).to redirect_to(root_url)
    end

    it "redirects to root on edit when not correct user" do
      log_in_as other_user
      get :show, params: { id: martial_art_saved.id }
      expect(response).to redirect_to(root_url)
    end


    it "removes martial art on destroy" do
      log_in_as user
      expect{
        delete :destroy, params: { id: martial_art_saved.id }
      }.to change{MartialArts::MartialArt.count}.by(-1)
    end

    it "creates a martial_art on create" do
      log_in_as user
      expect{
        post :create, params: {
          martial_art: {
            notes: 'note',
            duration_in_seconds: 1,
            occurred_time: "morning",
            occurred_date: Date.current
          }
        }
      }.to change{MartialArts::MartialArt.count}.by(1)
    end

    it "updates on update" do
      log_in_as user
      put :update, params: {
        id: martial_art_saved.id,
        martial_art: {
          notes: "updated"
        }
      }
      expect(martial_art_saved.reload.notes).to eq("updated")
    end

    it "applies the right math to the duration_in_minutes input" do
      log_in_as user
      put :update, params: {
        id: martial_art_saved.id,
        martial_art: {
          duration_in_minutes: "60"
        }
      }
      expect(martial_art_saved.reload.duration_in_seconds).to eq(3600)
    end

  end

end
