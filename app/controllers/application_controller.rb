class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def spotify_refresh_token
    current_user.refresh_token if current_user.token_expires_at < 5.minutes.from_now
  end

  def require_spotify_auth
    unless current_user&.spotify_token
      redirect_to root_path, alert: "Connexion avec Spotify requise"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username])
  end
end
