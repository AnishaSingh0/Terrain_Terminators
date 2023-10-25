class AvatarController < ApplicationController

    def avatar
          render "avatars"
        end    
      def choose_avatar
        filename = params[:avatar_filename]
        p "#{filename}"
        p "my user id is: #{current_user.id}"
        current_user.update(avatar_file: filename)
      end
  end