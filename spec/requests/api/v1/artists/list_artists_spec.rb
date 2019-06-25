require 'rails_helper'

RSpec.describe "List Artists", type: :request do
  context "with artists" do
    describe "GET /api/v1/artists" do
      before do
        Artist.create!(name: "Cool Band")
        Artist.create!(name: "Other Band")
      end

      it "lists all artists" do
        get api_v1_artists_path
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(2)
        expect(json_body.first).to include({
          name: "Cool Band",
        })
        expect(json_body.last).to include({
          name: "Other Band"
        })
      end
    end
  end

  context "with no artists" do
    describe "GET /api/v1/artists" do
      it "lists no artists" do
        get api_v1_artists_path
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(0)
      end
    end
  end
end
