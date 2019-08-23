module Api 
    module V1
        class PlaylistsController < ApplicationController 
            def index 
                @playlists = Playlist.all

                render json: @playlists
            end
            
            def show
                @playlist = Playlist.find(params[:id])

                render json: @playlist
            end

            def create 
                @playlist = Playlist.new(user_id: params[:id])
                @playlist.save!

                render json :@playlist
            end

            private 

            def playlist_params
                params.require(:id)
            end
        end
    end
end