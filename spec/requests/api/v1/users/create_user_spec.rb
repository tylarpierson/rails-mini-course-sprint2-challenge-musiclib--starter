require 'rails_helper'

RSpec.describe "Get Users", type: :request do
  describe "Create /api/v1/users" do
    let(:user_params) { { user: { email: "john@example.com" } } }

    it "creates a new user with a default api key" do
      post api_v1_users_path, params: user_params
      json_body = JSON.parse(response.body).deep_symbolize_keys

      expect(response).to have_http_status(201)
      expect(json_body).to include({
        email: "john@example.com",
        api_key: DEFAULT_API_KEY
      })
    end
  end
end
