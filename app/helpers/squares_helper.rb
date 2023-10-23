require 'httparty'
require 'base64'
require 'json'

module SquaresHelper
    def get_three_words(lat, lng)
        api_key = ENV['W3W_API_KEY']
        url = "https://api.what3words.com/v3/convert-to-3wa?coordinates=#{lat}%2C#{lng}&key=#{api_key}"
    
        response = HTTParty.get(url)
        
        if response.success?
          json_response = JSON.parse(response.body)
          p "JSON Response: #{json_response['words']}" 
          json_response['words']
        else
          # Handle error, maybe raise an exception or return an error message
          'Error fetching 3-word address'
        end
    end


      # app/helpers/image_generator_helper.rb


    def generate_image(words)
      return "squares/output_image.jpg"
  
    end 
    


  # def generate_image(words)
  #   url = 'https://api.wizmodel.com/sdapi/v1/txt2img'
  #   api_key = ENV['WIZMODEL_API_KEY']

  #   payload = {
  #     prompt: words,
  #     steps: 50
  #   }.to_json

  #   headers = {
  #     'Content-Type' => 'application/json',
  #     'Authorization' => "Bearer #{api_key}" # Replace with your actual API token
  #   }

  #   response = HTTParty.post(url, headers: headers, body: payload)
  #   p response
  #   base64_string = JSON.parse(response.body)['images'][0]

  #   # Decode the base64 string into bytes
  #   image_data = Base64.decode64(base64_string)
    
  #  # Define the file path within the public/assets directory
  #  file_path = Rails.root.join('app', 'assets', 'images','squares','output_image.jpg')

  #  # Save the image to the specified file path
  #  File.open(file_path, 'wb') do |f|
  #    f.write(image_data)
  #   end


  #   # Return the path to the saved image file
  #   "squares/output_image.jpg"
  # end

  # def words_logic(words)
  #   p(words)
  #   words_array = words.split('.')
  #   user_guesses = [params[:word1], params[:word2], params[:word3]].compact
  #   for word in words_array
  #     if word in user_guesses
  #       words_array -= word
  #     end
  #   end
  #   if words_array == []
  #     p "Destruction Complete!"
  #     # here a logic for redirection to the squares' page
  #   else
  #     remaining_words = words_array.join(' ')
  #     new_image = generate_image(remaining_words)
  #   end
  # end
  def get_remaining_words(square_words)
    square_words_array = square_words.split(' ')
    user_guesses_array = params[:words].split(' ')
    remaining_words = square_words_array - user_guesses_array
    return remaining_words.join(' ') 
  end 

  def covered_words(words)
    words.split(' ').map { |word| '*' * (word.length) }.join(' ')
  end

  # def uncovered_words(covered_words, square_words)
  #   covered_words_array = covered_words.split(' ')
  #   square_words_array = square_words.split(' ')
  #   uncovered_words_array = []
  #   for i in 0..covered_words_array.length - 1
  #     if covered_words_array[i] != square_words_array[i]
  #       uncovered_words_array << square_words_array[i]
  #     end
  #   end
  #   return uncovered_words_array.join(' ')
  # end

  # def get_display_words(correctly_guessed_words, square_words)
  #   covered_words_array = covered_words.split(' ')
  #   square_words_array = square_words.split(' ')
  #   uncovered_words_array = []
  
  #   covered_words_array.each_with_index do |word, i|
  #     uncovered_words_array << square_words_array[i] if word != '*' * word.length
  #   end
  
  #   uncovered_words_array.join(' ')
  # end

end
