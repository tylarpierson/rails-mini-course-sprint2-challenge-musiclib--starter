require 'rails_helper'

RSpec.describe "Get User", type: :request do
  describe "GET /api/v1/users/:id" do
    let(:user) { User.create!(email: "jane@example.com", api_key: DEFAULT_API_KEY) }

    it "gets the user" do
      get api_v1_user_path(user)
      json_body = JSON.parse(response.body).deep_symbolize_keys

      expect(response).to have_http_status(200)
      expect(json_body).to include({
        email: "jane@example.com",
        api_key: DEFAULT_API_KEY
      })
    end
  end
end
