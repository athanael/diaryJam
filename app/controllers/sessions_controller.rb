class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def spotify
    begin
      auth = request.env['omniauth.auth']

      user = User.find_or_initialize_by(
        spotify_id: auth['uid'],
        email: auth.dig('info', 'email')
      )

      user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
      user.username =  auth.dig('info', 'display_name')
      user.profile_image_url = auth.dig('info', 'images', 0, 'url')
      user.spotify_url = auth.dig('info', 'external_urls', 'spotify')
      user.spotify_token = auth.dig('credentials', 'token')
      user.spotify_refresh_token = auth.dig('credentials', 'refresh_token')
      user.token_expires_at = (Time.at(auth.dig('credentials', 'expires_at')) + 7.days).to_datetime

      if user.save
        sign_in(user)
        user.fetch_user_tracks
        redirect_to root_path, notice: 'Connecté à Spotify'
      else
        redirect_to root_path, notice: 'Erreur avec la connexion spotify'
      end
    rescue => e
      puts "Erreur : #{e.message}"
      puts "Backtrace : #{e.backtrace.join("\n")}"
      redirect_to root_path, alert: "Erreur lors de la connexion Spotify: #{e.message}"
    end
  end
end
