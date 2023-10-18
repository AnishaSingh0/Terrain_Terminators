class Square < ApplicationRecord
validates :lng, presence: true
  validates :lat, presence: true

  # Example method
  def coordinates
    "Longitude: #{lng}, Latitude: #{lat}"
  end
end
