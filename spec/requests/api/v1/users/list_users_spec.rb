require 'rails_helper'

RSpec.describe "List Users", type: :request do
  context "with users" do
    describe "GET /api/v1/users" do
      before do
        User.create!(email: "jane@example.com", api_key: DEFAULT_API_KEY)
        User.create!(email: "john@example.com", api_key: DEFAULT_API_KEY)
      end

      it "lists all users" do
        get api_v1_users_path
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(2)
        expect(json_body.first).to include({
          email: "jane@example.com",
          api_key: DEFAULT_API_KEY
        })
      end
    end
  end

  context "with no users" do
    describe "GET /api/v1/users" do
      it "lists no users" do
        get api_v1_users_path
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(0)
      end
    end
  end
end
