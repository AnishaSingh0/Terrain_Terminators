class GameController < ApplicationController
    def index
        @user = current_user # Fetch the user based on the provided user_id parameter
        @user_squares = UserSquare.where(user_id: @user.id) # Fetch all the user's squares
        render "index"
    end
end
