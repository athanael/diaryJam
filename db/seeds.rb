# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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

# IDs de morceaux Spotify pour le testing
track_ids = [
  "4uLU6hMCjMI75M1A2tKUQC", # Rick Roll
  "1dGr1c8CrMLDpV6mPbImSI", # The Weeknd - Blinding Lights
  "2P89NOLNfrwXRuotuqDxXr", # Realo - 2 SEC
  "1YOHWN62HHDszsqg5zQbo7", # kuru - save;File-9
  "3n4blG5eQN10jGA5LnNt6W"  # Lucy Bedroque - SISTERHOOD (LOVE, HER.)
]

# Création de 5 tracks + assignation à chaque utilisateur
users.each_with_index do |user, index|
  Track.find_or_create_by!(
    spotify_id: track_ids[index],
    user: user
  ) do |track|
    track.title = Faker::Music::RockBand.song
  end
end

puts "Ça a marché !"
