require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:new_user_attributes) do
    {
      name: "Blocipedia Head",
      email: "Blocipedia@testing.com",
      password: "blochead",
      password_confirmation: "blochead"
    }
  end

  describe "GET new" do
    it "returns https success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instatiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end
  
end
