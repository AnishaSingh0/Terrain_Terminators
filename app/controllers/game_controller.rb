class GameController < ApplicationController
    def index
        @user = current_user # Fetch the user based on the provided user_id parameter
        @user_squares = UserSquare.where(user_id: @user.id).order(:square_id)
        p @user_squares
        render "index"
    end
end
