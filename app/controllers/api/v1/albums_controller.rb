module Api
  module V1
    class AlbumsController < ApplicationController
      def index
        if params[:artist_id].present?
          @albums = Artist.find(params[:artist_id]).albums
        else
          @albums = Album.all
        end

        render json: @albums
      end

      def show
        @album = Album.find(params[:id])

        render json: @album
      end
    end
  end
end
