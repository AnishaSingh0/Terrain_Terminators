require 'httparty'
require 'net/http'
require 'json'

module GameHelper
    

    def get_coordinates(location)
        base_url = "https://maps.googleapis.com/maps/api/geocode/json"
        api_key = ENV['GEOCODE_API_KEY'] # Replace with your actual Google Maps API key
    
        response = HTTParty.get(base_url, query: { address: location, key: api_key })
        data = JSON.parse(response.body)
    
        if response.code == 200 && data["status"] == "OK"
          latitude = data["results"][0]["geometry"]["location"]["lat"]
          longitude = data["results"][0]["geometry"]["location"]["lng"]
          return latitude, longitude
        else
          Rails.logger.error("Error: Unable to fetch coordinates.")
          return nil, nil
        end
      end

 
def get_grid_section(latitude, longitude)
  # Define the radius (in degrees) for the bounding box
  radius = 0.00015
  api_key = ENV['GEOCODE_API_KEY'] # Replace with your actual Google Maps API key


  # Calculate southwest and northeast corners
  latitude_sw = latitude - radius
  longitude_sw = longitude - radius
  latitude_ne = latitude + radius
  longitude_ne = longitude + radius

  # Construct the API URL
  api_key = ENV['W3W_API_KEY'] # Replace with your actual API key
  url = "https://api.what3words.com/v3/grid-section?key=#{api_key}&bounding-box=#{latitude_sw},#{longitude_sw},#{latitude_ne},#{longitude_ne}&format=json"

  # Make the API request
  uri = URI(url)
  response = HTTParty.get(uri)

  # Check if the request was successful
  coordinates = []
  if response.code == 200
    squares = response["lines"]
    # Process the API response data here
    squares.each do |square|
      lat = square["end"]["lat"]
      lng = square["end"]["lng"]
      coordinates << { lat: lat, lng: lng }
    end
    return coordinates
  else
    puts "Error: Unable to fetch data. Status code: #{response.code}"
    return nil
  end
end

def get_three_words(lat, lng)
  api_key = ENV['W3W_API_KEY'] # Replace with your actual API key
  url = "https://api.what3words.com/v3/convert-to-3wa"

  response = HTTParty.get(url, query: { coordinates: "#{lat},#{lng}", key: api_key })

  if response.code == 200
    data = JSON.parse(response.body)
    words = data["words"]
    return words
  else
    puts "Error: Unable to fetch data. Status code: #{response.code}"
    return nil
  end
end
end
