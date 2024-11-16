require 'open-uri'
require 'cloudinary'
require 'rspotify'

# Initialiser l'authentification Spotify
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

puts "Création de 4 utilisateurs avec photos de profil..."
Post.destroy_all
Track.destroy_all
User.destroy_all

# IDs de morceaux Spotify pour le testing (quatre morceaux différents pour chaque utilisateur)
user_track_ids = [
  ["4uLU6hMCjMI75M1A2tKUQC", "1kuGVB7EU95pJObxwvfwKS", "1BxfuPKGuaTgP7aM0Bbdwr", "1YOHWN62HHDszsqg5zQbo7"],
  ["4O594chXfv4lHvneDP0Ud0", "5b88tNINg4Q4nrRbrCXUmg", "5PsMbxhgWpJMsouEfDTX6r", "7b71WsDLb8gG0cSyDTFAEW"],
  ["1R2SZUOGJqqBiLuvwKOT2Y", "2CAK2t1reUgPK6OMgAMURB", "2Foc5Q5nqNiosCNqttzHof", "4YiEKrJuoZGGg3nzTJfONS"],
  ["2wBW9jGZRRMbQ416NDc7LW", "5vQctmBxi79lyQoc2DDAsP", "4suom7B7d6DQa2YTPBT1lv", "4xJjD28UsZlqbX7tBV3Aj5"]
]

# Création de 4 utilisateurs avec photos de profil
users_data = [
  { email: 'imad@diaryjam.fr', first_name: 'Imad', last_name: 'Belhadri', username: 'imadbelhadri', profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/e8biamqsueqxqteyjnv4.jpg' },
  { email: 'athanael@diaryjam.fr', first_name: 'Athanael', last_name: 'Gerard', username: 'athanaelgerard', profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/xgnsg0eoii8hvesehb0y.png' },
  { email: 'damien@diaryjam.fr', first_name: 'Damien', last_name: 'Merian', username: 'damienmerian', profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/cj80nxdsmciofyeavver.png' },
  { email: 'argjent@diaryjam.fr', first_name: 'Argjent', last_name: 'Goga', username: 'argjentgoga', profile_image_url: 'https://res.cloudinary.com/dxolsqoem/image/upload/v1731369783/bcvv1sgsb3qnowwxbkg4.jpg' }
]

users = users_data.map { |user_data| User.create!(user_data.merge(password: 'azerty')) }

puts "Création des morceaux pour chaque utilisateur..."


users.each_with_index do |user, index|
  user_track_ids[index].each do |track_id|
    spotify_track = RSpotify::Track.find(track_id)
    user.tracks.create!(
      spotify_id: spotify_track.id,
      title: spotify_track.name,
      artist: spotify_track.artists.first.name,
      duration_ms: spotify_track.duration_ms # Corrigé pour utiliser "duration_ms" comme dans ton schéma
    )
  end
end

puts "Création de 5 morceaux pour chaque utilisateur..."
#   users.each_with_index do |user, index|
#   puts index
#   puts user

# Création de 5 posts pour chaque utilisateur, chacun lié à un des morceaux de l'utilisateur
posts_data = [
  { content: "J'adore ce morceau !"},
  { content: "Ce morceau est incroyable !"},
  { content: "Je n'ai pas aimé celui-ci"},
  { content: "Bof Bof"},
  { content: "..."}
]

users.each do |user|
  user.tracks.each do |track|
    posts_data.each do |post_data|
      user.posts.create!(post_data.merge(track: track))
    end
  end
end

puts "4 utilisateurs avec leurs morceaux et posts créés avec succès !"
