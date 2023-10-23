class SquaresController < ApplicationController
    include SquaresHelper

    def show
      @square = Square.find(params[:id])
      if @square.words == nil
        @three_words = get_three_words(@square.lat, @square.lng) 
        @three_words = @three_words.split('.').join(' ')
        @covered_words = covered_words(@three_words)
        # @covered_words = @three_words.split(' ').map { |word| '*' * (word.length) }.join(' ')
        @square.update(words: @three_words)
        @image_path = generate_image(@square.words)
        @square.update(image_url: @image_path)
      end
      @covered_words = covered_words(@square.words)
      # @covered_words = @square.words.split(' ').map { |word| '*' * (word.length) }.join(' ')

      p params[:message] 
      @message = params[:message]

    
  end
    
  def squares_words_logic
    # Call the words_logic function here
    @square = Square.find(params[:id])
    remaining_words = get_remaining_words(@square.words)
    p remaining_words

    if remaining_words == ""
      @square.update(words: remaining_words) 
      redirect_to "/squares/#{params[:id]}?message=All%20words%20found!"
    elsif @square.words != remaining_words
      @square.update(words: remaining_words) 
      @image_path = generate_image(@square.words)
      @square.update(image_url: @image_path) 
      redirect_to "/squares/#{params[:id]}?message=correct"
    else 
      redirect_to "/squares/#{params[:id]}?message=incorrect"
    end

    end
end
