require 'rails_helper'

RSpec.describe "Get Artist", type: :request do
  describe "GET /api/v1/artists/:id" do
    let(:artist) { Artist.create!(name: "Super Cool Band") }

    it "gets the artist" do
      get api_v1_artist_path(artist)
      json_body = JSON.parse(response.body).deep_symbolize_keys

      expect(response).to have_http_status(200)
      expect(json_body).to include({
        name: "Super Cool Band"
      })
    end
  end
end
