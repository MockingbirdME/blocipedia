require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}

  it { is_expected.to have_many(:created_wikis)}
  it { is_expected.to have_many(:collaborations)}
  it { is_expected.to have_many(:collaborating_wikis)}

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
    it "responds to member?" do
      expect(user).to respond_to(:premium?)
    end
    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end
  end

  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eq("standard")
    end
    it "can change user roles" do
      user.change_user_role(1)
      expect(user.role).to eq "premium"
    end
    context "standard user" do
      it "returns true for standard?" do
        expect(user.standard?).to be_truthy
      end
      it "returns false for premium?" do
        expect(user.premium?).to be_falsey
      end
      it "returns false for admin?" do
        expect(user.admin?).to be_falsey
      end
    end
    context "premium user" do
      before do
        user.premium!
      end
      it "returns false for standard?" do
        expect(user.standard?).to be_falsey
      end
      it "returns true for premium?" do
        expect(user.premium?).to be_truthy
      end
      it "returns false for admin?" do
        expect(user.admin?).to be_falsey
      end
    end
    context "admin user" do
      before do
        user.admin!
      end
      it "returns false for standard?" do
        expect(user.standard?).to be_falsey
      end
      it "returns false for premium?" do
        expect(user.premium?).to be_falsey
      end
      it "returns true for admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe "avatar_url" do
    it "links to gravatar for user email" do
      url = user.avatar_url(128)
      expect(url).to eq "http://gravatar.com/avatar/8735be3fc8240d1d815dc94c47246d49.png?s=128"
    end
  end

end
