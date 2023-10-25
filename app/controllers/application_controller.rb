class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def after_sign_in_path_for(resource)

        # authenticated_root_path # Redirect to the game page after sign in
        "/avatars"

    end

    def after_sign_up_path_for(resource)
        '/avatar' # Redirect to the game page after sign up
    end

    def after_sign_out_path_for(resource)
        unauthenticated_root_path
    end
  
end