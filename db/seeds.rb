# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# IDs de morceaux Spotify pour le testing
track_ids = [
  "4PTG3Z6ehGkBFwjybzWkR8", # Rick Roll
  "0VjIjW4GlUZAMYd2vXMi3b", # The Weeknd - Blinding Lights
  "2ChF0wBv2U5p8gAMnnigre", # Realo - 2 SEC
  "1YOHWN62HHDszsqg5zQbo7", # kuru - save;File-9
  "3n4blG5eQN10jGA5LnNt6W"  # Lucy Bedroque - SISTERHOOD (LOVE, HER.)
]

# Création de 5 utilisateurs
users = 5.times.map do |i|
  User.find_or_create_by!(
    email: "user#{i + 1}@example.com"
  ) do |user|
    user.password = "password"
    user.username = "User#{i + 1}"
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.spotify_id = Faker::Number.number(digits: 10)
  end
end

# Création de tracks à partir de Spotify
users.each_with_index do |user, index|
  spotify_track = RSpotify::Track.find(track_ids[index])

  Track.find_or_create_by!(
    spotify_id: spotify_track.id,
    user: user
  ) do |track|
    track.title = spotify_track.name
    track.artist = spotify_track.artists.first.name
    track.preview_url = spotify_track.preview_url
    track.image_url = spotify_track.album.images.first['url'] if spotify_track.album.images.any?
  end
end

puts "Seeds avec RSpotify terminés !"
