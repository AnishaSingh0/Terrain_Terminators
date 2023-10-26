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


  # def generate_image(words)
    # return "squares/output_image.jpg"

  #   response = HTTParty.post("https://api.openai.com/v1/images/generations",
  #     headers: {
  #       "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}",
  #       "Content-Type" => "application/json"
  #     },
  #     body: {
  #       prompt: words,
  #       n: 1,
  #       size: "1024x1024"
  #     }.to_json
  #   )
    
  #   p response
  #   image_url = response['data'][0]['url']
    
  #   # Download the image and save it locally
  # File.open("output_image.jpg", 'wb') do |file|
  #   file.write open(image_url).read
  # end

  # Return the local file path
#   return "output_image.jpg"
# end 
# url = 'https://api.wizmodel.com/sdapi/v1/txt2img'
# api_key = ENV['WIZMODEL_API_KEY']

# payload = {
#   prompt: words,
#   steps: 50
# }.to_json

# headers = {
#   'Content-Type' => 'application/json',
#   'Authorization' => "Bearer #{api_key}"
# }

# response = HTTParty.post(url, headers: headers, body: payload)
# base64_string = JSON.parse(response.body)['images'][0]

# # Decode the base64 string into bytes
# image_data = Base64.decode64(base64_string)

# # Define the file path within the public/assets directory
# image_number = Time.now.to_i # Get a unique number for the image name
# file_name = "image#{image_number}.jpg"
# file_path = Rails.root.join('app', 'assets', 'images', 'squares', file_name)

# # Save the image to the specified file path
# File.open(file_path, 'wb') do |f|
#   f.write(image_data)
# end

# relative_path = file_path.relative_path_from(Rails.root.join('app', 'assets', 'images'))
# relative_path.to_s
# end

require 'aws-sdk-s3'

def generate_image(words)
  url = 'https://api.wizmodel.com/sdapi/v1/txt2img'
  api_key = ENV['WIZMODEL_API_KEY']

  payload = {
    prompt: words,
    steps: 50
  }.to_json

  headers = {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{api_key}"
  }

  response = HTTParty.post(url, headers: headers, body: payload)
  base64_string = JSON.parse(response.body)['images'][0]

  # Decode the base64 string into bytes
  image_data = Base64.decode64(base64_string)

  # Define the file name (object key)
  image_number = Time.now.to_i
  file_name = "image#{image_number}.jpg"
  aws_credentials = Rails.application.credentials.aws


  # Upload the image to S3 bucket
  s3 = Aws::S3::Resource.new(
    access_key_id: aws_credentials[:access_key_id],
    secret_access_key: aws_credentials[:secret_access_key],
    region: 'eu-west-2' # Change this to your desired AWS region
  )
  bucket = s3.bucket('ttsquaresdev')

  # Upload the image to the specified S3 bucket with the defined file name (object key)
  obj = bucket.object(file_name)
  obj.put(body: image_data, content_type: 'image/jpeg', acl: 'public-read')

  # Return the object key (file name) after uploading to S3 bucket
  file_name
end



  def get_remaining_words(square_words)
    square_words_array = square_words.split(' ')
    user_guesses_array = params[:words].split(' ')
    remaining_words = square_words_array - user_guesses_array
    return remaining_words.join(' ') 
  end 


  def get_display_words(remaining_words, square_words)
    square_words_array = square_words.split
    remaining_words_array = remaining_words.split
    # Replace words in square_words with asterisks if they exist in remaining_words
    result = square_words_array.map do |word|
      if remaining_words_array.include?(word)
        translate(word)
      else
        word
      end
    end 
    result.join(' ')
  end

  def translate(word)
    alphabet_dict = {"a"=>"▣", "b"=>"▤","c"=>"▥","d"=>"▦","e"=>"▧","f"=>"▨","g"=>"▩","h"=>"◧","i"=>"◨","j"=>"☰","k"=>"☱","l"=>"☲","m"=>"☳","n"=>"☴","o"=>"☵","p"=>"☶","q"=>"☷","r"=>"◩","s"=>"◪","t"=>"◫","u"=>"◰","v"=>"◱","w"=>"◲","x"=>"◳","y"=>"□","z"=>"■"}
    translated_word = ""
    for char in word.chars do
      print(translated_word)
      translated_word += alphabet_dict[char]
    end
    translated_word
  end

end
