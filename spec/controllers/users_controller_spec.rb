require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}

  context "signed in user" do
    before do
      sign_in user
    end
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: user.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
