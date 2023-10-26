class SquaresController < ApplicationController
  before_action :authenticate_user! 
  include SquaresHelper

    def show
      @square = Square.find(params[:id])
      @user = current_user
      @user_square = UserSquare.find_or_initialize_by(user: @user, square: @square)
      object_key = @user_square.image_path # Replace this with the actual object key of the image you want to access
      bucket_name = "ttsquaresdev"
      @s3_url = "https://#{bucket_name}.s3.amazonaws.com/#{object_key}"
 
      @display_words = get_display_words(@user_square.remaining_words , @square.words)
      @message = params[:message]
  end
    
  def squares_words_logic
    @square = Square.find(params[:id])
    user = current_user # this is the user that is logged in
    # add user id, square id, and remaining words to user_squares table
    @user_square = UserSquare.find_or_initialize_by(user: user, square: @square)
    remaining_words = get_remaining_words(@user_square.remaining_words)
    p @user_square
    # @user_square.remaining_words = remaining_words
    # @user_square.save

    # User guessed everything correctly 
    if remaining_words == ""
      @user_square.update(remaining_words: remaining_words) 
      @user_square.update(is_destroyed: true)
      redirect_to "/squares/#{params[:id]}?message=All%20words%20found!"
    
    # User guessed at least one word correctly
    elsif @user_square.remaining_words != remaining_words
      @user_square.update(remaining_words: remaining_words) 
      @image_path = generate_image(@user_square.remaining_words)
      @user_square.update(image_path: @image_path) 
      
      redirect_to "/squares/#{params[:id]}?message=correct"
    else 
      redirect_to "/squares/#{params[:id]}?message=incorrect"
    end

    end
end
