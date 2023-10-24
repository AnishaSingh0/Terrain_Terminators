class GameController < ApplicationController
    def index
        @user = current_user # Fetch the user based on the provided user_id parameter
        @user_squares = UserSquare.where(user_id: @user.id).order(:square_id)
        p @user_squares
        render "index"
    end

    def save_location
        latitude = params[:latitude]
        longitude = params[:longitude]
        
        # Do something with latitude and longitude, such as saving them to the database
        
        return latitude, longitude
      end
end
