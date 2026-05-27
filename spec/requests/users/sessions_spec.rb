require "rails_helper"

RSpec.describe Users::SessionsController, type: :request do
  let(:user)  { create(:user) }

  context "POST /users/sign_in" do
    it "signs in with valid credentials" do
      post "/users/sign_in", params: { user: { email: user.email, password: "password123" } }

      expect(response).to have_http_status(:ok)
    end

    it "returns a 401 response with an incorrect password" do
      post "/users/sign_in", params: { user: { email: user.email, password: "passwordABC" } }

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns a 401 response with an invalid email" do
      post "/users/sign_in", params: { user: { email: "foo1.bar.baz", password: "passwordABC" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "DELETE /users/sign_out" do
    it "signs out with valid credentials" do
      post "/users/sign_in", params: { user: { email: user.email, password: "password123" } }
      token = response.headers["Authorization"]

      delete "/users/sign_out", headers: { Authorization: token }
      expect(response).to have_http_status(:no_content)
    end

    it "returns a 401 response with no token" do
      delete "/users/sign_out"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns a 401 response with an already revoked token" do
      post "/users/sign_in", params: { user: { email: user.email, password: "password123" } }
      token = response.headers["Authorization"]

      delete "/users/sign_out", headers: { Authorization: token }
      delete "/users/sign_out", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
