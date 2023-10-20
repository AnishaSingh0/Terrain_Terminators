class SquaresController < ApplicationController
    include SquaresHelper

   

    def show
        @square = Square.find(params[:id])
        if @square.words == ""
          @three_words = get_three_words(@square.lat, @square.lng) 
          @three_words = @three_words.split('.').join(' ')
          @square.update(words: @three_words)
        end 
        p "Three Words: #{@square.words}" 
        @image_path = generate_image(@square.words)
        # Enqueue the GenerateImageJob to run asynchronously in the background
      
    end
    
    def squares_words_logic
      # Call the words_logic function here
      @square = Square.find(params[:id])
      remaining_words = get_remaining_words(@square.words)
      p remaining_words
      @square.update(words: remaining_words)

      if @square.words == remaining_words
        flash.now[:error] = "Words have not changed."
        render 'error'
        
      elsif remaining_words != ""
        redirect_to "/squares/#{params[:id]}"
      else 
        redirect_to "/game"
      end

 

    end
end
