require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :request do
  let(:user)  { create(:user) }
  it "signs up with valid credentials" do
    post "/users", params: { user: { email: "foo@bar.baz", password: "password123" } }

    expect(response).to have_http_status(:created)
  end

  it "returns a 422 response with an invalid email format" do
    post "/users", params: { user: { email: "foo.bar.baz", password: "password123" } }

    expect(response).to have_http_status(:unprocessable_content)
  end

  it "returns a 422 response with a missing password" do
    post "/users", params: { user: { email: "foo@bar.baz", password: "" } }

    expect(response).to have_http_status(:unprocessable_content)
  end

  it "returns a 422 response with a duplicate email" do
    post "/users", params: { user: { email: user.email, password: "password123" } }

    expect(response).to have_http_status(:unprocessable_content)
  end
end
