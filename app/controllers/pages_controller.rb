class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      Spotify.fetch_recent_tracks(current_user)
      @tracks = current_user.spotify_tracks
    end
  end
end
