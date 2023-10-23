class SquaresController < ApplicationController
  before_action :authenticate_user! 
  include SquaresHelper

    def show
        @square = Square.find(params[:id])
        @three_words = get_three_words(@square.lat, @square.lng)
        @image_path = generate_image(@three_words)
      
        # Enqueue the GenerateImageJob to run asynchronously in the background
      
      end
end
