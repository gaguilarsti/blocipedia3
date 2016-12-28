require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "User Name", email:"user@example.com", password: "helloworld") }

  #shoulda test for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  #shoulda test for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@example.com").for(:email) }

  #shoulda test for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name, email and password attributes" do
      expect(user).to have_attributes(name: "User Name", email: "user@example.com", password: "helloworld")
    end

    it "responds to a role" do
      expect(user).to respond_to(:role)
    end

    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
  end

  describe "roles" do

    it "is standard by default" do
      expect(user.role).to eql("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium" do
        expect(user.premium?).to be_falsey
      end
    end

    context "premium user" do
      before do
        user.premium!
      end

      it "returns true for #premium" do
        expect(user.premium?).to be_truthy
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #premium" do
        expect(user.premium?).to be_falsey
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end


  end

  let(:user_with_invalid_name) { User.new(name: "", email: "user@example.com") }
  let(:user_with_invalid_email) { User.new(name: "User Name", email: "") }

  describe "Invalid User" do
    it "should be an invalid user if name is empty" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user if email is empty" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end



end
