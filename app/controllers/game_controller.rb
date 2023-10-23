class GameController < ApplicationController
    def index
        @user = current_user # Fetch the user based on the provided user_id parameter
        @user_squares = @user.squares.limit(12) 
        p "here"
        p"are"
        p"all"
        p @user_squares
        render "index"
    end
end
