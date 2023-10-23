class SquaresController < ApplicationController
    include SquaresHelper

    def show
      @square = Square.find(params[:id])
      @user = current_user
      @user_square = UserSquare.find_or_initialize_by(user: @user, square: @square)
      @user_square.save
      @three_words = get_three_words(@square.lat, @square.lng) 
      if @square.words == nil
        @three_words = @three_words.split('.').join(' ')
        @covered_words = covered_words(@three_words)
        # @covered_words = @three_words.split(' ').map { |word| '*' * (word.length) }.join(' ')
        @square.update(words: @three_words)
        @image_path = generate_image(@square.words)
        @square.update(image_url: @image_path)
      end 
      if @user_square.remaining_words == nil
        @user_square.remaining_words = @three_words 
        @user_square.save
        p ("here")
        # @covered_words = covered_words(@three_words)
    
      else
        p "here"
         # this is the user that is logged in
        # @covered_words = covered_words(@user_square.remaining_words)
      # @covered_words = @square.words.split(' ').map { |word| '*' * (word.length) }.join(' ')
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
    @user_square.remaining_words = remaining_words
    @user_square.save

    # User guessed everything correctly 
    if remaining_words == ""
      @square.update(words: remaining_words) 
      redirect_to "/squares/#{params[:id]}?message=All%20words%20found!"
    
    # User guessed at least one word correctly
    elsif @square.words != remaining_words
      @user_square.update(remaining_words: remaining_words) 
      @image_path = generate_image(@user_square.remaining_words)
      @user_square.update(image_path: @image_path) 
      redirect_to "/squares/#{params[:id]}?message=correct"
    else 
      redirect_to "/squares/#{params[:id]}?message=incorrect"
    end

    end
end
