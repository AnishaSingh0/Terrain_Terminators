class Square < ApplicationRecord
validates :lng, presence: true
  validates :lat, presence: true
  has_many :user_squares
  has_many :users, through: :user_squares

  # Example method
  def coordinates
    "Longitude: #{lng}, Latitude: #{lat}"
  end
end
