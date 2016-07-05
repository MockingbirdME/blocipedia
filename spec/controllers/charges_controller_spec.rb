require 'rails_helper'

RSpec.describe ChargesController, type: :controller do


let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}

context "signed in user" do
  before do
    sign_in user
  end
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end
end
