class User < ApplicationRecord
  validates :email, :api_key, presence: true
end
