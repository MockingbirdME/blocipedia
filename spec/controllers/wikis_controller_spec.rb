require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}
  let(:wiki) {Wiki.create!(title: "my wiki", body: "my wiki text", private: false, user: user)}


  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([wiki])
    end
  end

=begin
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
=end
end
