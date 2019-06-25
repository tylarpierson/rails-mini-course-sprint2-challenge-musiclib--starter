require 'rails_helper'

RSpec.describe "List Artist Albums", type: :request do
  let(:artist) { Artist.create!(name: "Cool Band") }

  context "with albums" do
    describe "GET /api/v1/artists/:artist_id/albums" do
      before do
        artist.albums.create!(name: "Cool Album")
        artist.albums.create!(name: "Lame Album")
      end

      it "lists all albums for artist" do
        get api_v1_artist_albums_path(artist)
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(2)
        expect(json_body.first).to include({
          name: "Cool Album",
        })
        expect(json_body.last).to include({
          name: "Lame Album"
        })
      end
    end
  end

  context "with no albums" do
    describe "GET /api/v1/artists/:artist_id/albums" do
      it "lists no albums" do
        get api_v1_artist_albums_path(artist)
        json_body = JSON.parse(response.body).map(&:deep_symbolize_keys)

        expect(response).to have_http_status(200)
        expect(json_body.count).to eq(0)
      end
    end
  end
end
