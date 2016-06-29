require 'rails_helper'

RSpec.describe Wiki, type: :model do
let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}
let(:wiki) {Wiki.create!(title: "my wiki", body: "my wiki text", private: false, user: user)}

  it {is_expected.to belong_to(:user)}
  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:user)}

  describe "attributes" do
    it "has title, body, boolean, and user attributs" do
      expect(wiki).to have_attributes(title: "my wiki", body: "my wiki text", private: false, user: user)
    end
  end

end
