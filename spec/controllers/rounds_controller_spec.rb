require 'rails_helper'

RSpec.describe RoundsController, type: :controller do

  fixtures :users, :rounds
  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  let(:user) { users(:martial_artist) }
  let(:other_user) { users(:archer) }

  let(:martial_art) { martial_arts(:jiu_jitsu) }

  let(:round_saved) { rounds(:roll) }

  describe "#general" do
    it "redirects to login if logged out" do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  describe "#index" do
    it "redirects to home page if logged in" do
      log_in_as user
      get :index
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#new" do
    it "redirects to root if incorrect user" do
      log_in_as other_user
      get :new, params: {
        martial_art_id: martial_art.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#create" do
    it "creates" do
      log_in_as user
      expect{
        post :create, params: {
          martial_art_id: martial_art.id,
          round: {
            partner_name: "chris"
          }
        }
      }.to change{Round.count}.by(1)
    end

    it "redirects to root and does not create if incorrect user" do
      log_in_as other_user
      expect{
        post :create, params: {
          martial_art_id: martial_art.id,
          round: {
            partner_name: "link"
          }
        }
      }.to_not change{Round.count}
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#edit" do
    it "redirects to root if wrong user" do
      log_in_as other_user
      get :edit, params: {
        id: round_saved.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#update" do
    it "updates" do
      log_in_as user
      put :update, params: {
        id: round_saved.id,
        round: {
          notes: "updated"
        }
      }
      expect(round_saved.reload.notes).to eq("updated")
    end

    it "redirects if wrong user and does not update" do
      log_in_as other_user
      put :update, params: {
        id: round_saved.id,
        round: {
          notes: "updated wrong"
        }
      }
      expect(round_saved.reload.notes).to_not eq("updated wrong")
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#destroy" do
    it "destroys" do
      log_in_as user
      expect{
        delete :destroy, params: {
            id: round_saved.id
        }
      }.to change{Round.count}.by(-1)
    end

    it "redirects if wrong user and does not destroy" do
      log_in_as other_user
      expect{
        delete :destroy, params: {
            id: round_saved.id
        }
      }.to_not change{Round.count}
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#show" do
    it "redirects to martial art if correct user" do
      log_in_as user
      get :show, params: {
        id: round_saved.id
      }
      expect(response).to redirect_to(martial_art_path(martial_art))
    end

    it "redirects to root if wrong user" do
      log_in_as other_user
      get :show, params: {
        id: round_saved.id
      }
      expect(response).to redirect_to(root_url)
    end
  end



end
