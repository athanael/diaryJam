require 'open-uri'
require 'cloudinary'
require 'rspotify'

puts "Création de 4 utilisateurs avec photos de profil..."
User.destroy_all
# IDs de morceaux Spotify pour le testing
track_ids = [
  "4uLU6hMCjMI75M1A2tKUQC", # Rick Roll
  "3H7ihDc1dqLriiWXwsc2po", # The Weeknd - Blinding Lights
  "29P9xbKLiQY2UzWJBvY2mB", # Realo - 2 SEC
  "2YoHh6nEm0sRsqsSbOzb07", # kuru - save;File=9
  "3hab5OEl2ksbNbG1AsLNw6"  # Lucy Bedroque - SISTERHOOD (LOVE, HER.)
]

puts "Connexion à Spotify..."
# Création de 4 utilisateurs avec photos de profil
User.create!(
  email: 'imad@diaryjam.fr',
  password: 'azerty',
  first_name: 'Imad',
  last_name: 'Belhadri',
  username: 'imadbelhadri',
  profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/e8biamqsueqxqteyjnv4.jpg'
)

User.create!(
  email: 'athanael@diaryjam.fr',
  password: 'azerty',
  first_name: 'Athanael',
  last_name: 'Gerard',
  username: 'athanaelgerard',
  profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/xgnsg0eoii8hvesehb0y.png'
)

User.create!(
  email: 'damien@diaryjam.fr',
  password: 'azerty',
  first_name: 'Damien',
  last_name: 'Merian',
  username: 'damienmerian',
  profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/cj80nxdsmciofyeavver.png'
)

User.create!(
  email: 'argjent@diaryjam.fr',
  password: 'azerty',
  first_name: 'Argjent',
  last_name: 'Goga',
  username: 'argjentgoga',
  profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/bcvv1sgsb3qnowwxbkg4.jpg'
)

users = User.all

users.each do |user|
  track_ids.each do |track_id|
    spotify_track = RSpotify::Track.find(track_id)
    user.tracks.create!(
      spotify_id: spotify_track.id,
      title: spotify_track.name,
      artist: spotify_track.artists.first.name,
      duration: spotify_track.duration_ms / 1000 # en secondes
    )
  end
end

puts "Création de 5 morceaux pour chaque utilisateur..."
#   users.each_with_index do |user, index|
#   puts index
#   puts user

#   puts track_ids[index]
#   spotify_track = RSpotify::Track.find(track_ids[index])

#   Track.find_or_create_by!(
#     spotify_id: spotify_track.id,
#     user: user
#   ) do |track|
#     track.title = spotify_track.name
#     track.artist = spotify_track.artists.first.name
#     track.preview_url = spotify_track.preview_url
#     track.image_url = spotify_track.album.images.first['url'] if spotify_track.album.images.any?
#   end
# end

puts "4 utilisateurs avec photos de profil créés avec succès !"
