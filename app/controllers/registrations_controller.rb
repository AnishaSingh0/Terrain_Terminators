class RegistrationsController < Devise::RegistrationsController
    private
      def sign_up_params
        params.require(:user).permit(:email, :password, :username)
      end
    
    protected 
    def after_sign_up_path_for(resource)
        '/avatar' # Redirect to the game page after sign up
    end

    def after_inactive_sign_up_path_for(resource)
      '/an/example/path' # Or :prefix_to_your_route
    end

end