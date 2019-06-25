module Api
  module V1
    module Artists
      class AlbumsController < ApplicationController
        def index
          @albums = Artist.find(params[:artist_id]).albums

          render json: @albums
        end
      end
    end
  end
end
