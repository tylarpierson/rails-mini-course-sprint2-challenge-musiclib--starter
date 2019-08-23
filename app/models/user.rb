class User < ApplicationRecord
  validates :email, :api_key, presence: true

  has_many :playlists
end
