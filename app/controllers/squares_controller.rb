class SquaresController < ApplicationController
    include SquaresHelper

    def show
        @square = Square.find(params[:id])
        @three_words = get_three_words(@square.lat, @square.lng)
        @image_path = generate_image(@three_words)
        @words_logic = words_logic(@three_words)
        # Enqueue the GenerateImageJob to run asynchronously in the background
      
      end
end
