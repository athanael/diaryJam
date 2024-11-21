require 'open-uri'
require 'cloudinary'
require 'rspotify'

# Initialiser l'authentification Spotify
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

puts "suppréssion des user track & post..."
Post.destroy_all
Track.destroy_all
User.destroy_all
