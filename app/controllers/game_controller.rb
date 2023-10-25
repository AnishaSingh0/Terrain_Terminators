class GameController < ApplicationController
    before_action :authenticate_user! 
    include GameHelper
    include SquaresHelper

    # GET /game
    def index
        @user = current_user # Fetch the user based on the provided user_id parameter
        @user_squares = UserSquare.where(user_id: @user.id).order(:square_id)
        p @user_squares
        render "index"
    end

    def avatars
        render 'avatars'
    end 

    def location 
    user = current_user
    location = params[:location]
    latitude, longitude = get_coordinates(location)
    coordinates = get_grid_section(latitude, longitude)
    words = []
    p words 
    for coordinate in coordinates
        word = get_three_words(coordinate[:lat], coordinate[:lng])
        p word 
        words << word
        if words.length <= 12 
            square = Square.create(lat: coordinate[:lat], lng: coordinate[:lng], words: word.split('.').join(' '))
            p square
            user_square = UserSquare.create(user_id: user.id, square_id: square.id, remaining_words: word.split('.').join(' '))
            p user_square
            image_path = generate_image(word.split('.').join(' '))
            user_square.update(image_path: image_path)
        end
    end 
   
    end 

end
