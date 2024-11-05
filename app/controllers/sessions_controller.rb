class SessionsController < ApplicationController
  def spotify
    auth = request.env['omniauth.auth']

    user = User.find_or_create_by(spotify_uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.spotify_token = auth['credentials']['token']
      u.spotify_refresh_token = auth['credentials']['refresh_token']
    end

    sign_in(user)
    redirect_to root_path, notice: "Connecté avec Spotify!"
  end
end
