class SquaresController < ApplicationController
  before_action :authenticate_user! 
  include SquaresHelper

    def show
      @square = Square.find(params[:id])
      @user = current_user
      @user_square = UserSquare.find_or_initialize_by(user: @user, square: @square)
      @user_square.save
      @three_words = get_three_words(@square.lat, @square.lng) 
      @three_words = @three_words.split('.').join(' ')

      if @square.words == nil
        @square.update(words: @three_words)
        @image_path = generate_image(@square.words)
        @square.update(image_url: @image_path)
        @user_square.remaining_words = @three_words 
        @user_square.save
        @display_words = get_display_words(@three_words, @three_words)
      end 

      if @user_square.remaining_words == nil
        @user_square.remaining_words = @three_words 
        @user_square.save
        @display_words = get_display_words(@user_square.remaining_words , @square.words)
      else
        @display_words = get_display_words(@user_square.remaining_words , @square.words)
      end 

      if @user_square.remaining_words == ""
        @display_words = @square.words
      end 

      p params[:message] 
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
