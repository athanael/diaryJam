class Spotify < ApplicationRecord
  belongs_to :user

  def self.fetch_recent_tracks(user)
    service = SpotifyService.new(user.spotify_token)
    recent_tracks = service.recent_tracks

    user.spotify_tracks.destroy_all

    recent_tracks.each do |track_data|
      user.spotify_tracks.create(
        name: track_data["track"]["name"],
        artist: track_data["track"]["artists"].map { |artist| artist["name"] }.join(", "),
        album_name: track_data["track"]["album"]["name"],
        album_image_url: track_data["track"]["album"]["images"][0]["url"],
        spotify_id: track_data["track"]["id"]
      )
    end
  end
end
