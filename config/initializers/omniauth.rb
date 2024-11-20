require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"],
  scope: 'user-read-email
          user-library-read
          user-read-recently-played
          user-top-read',
  provider_ignores_state: true
end
