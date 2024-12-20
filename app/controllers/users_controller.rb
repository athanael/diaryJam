class UsersController < ApplicationController

  before_action :require_spotify_auth, only: [:show, :recommendations]
  before_action :spotify_refresh_token
  def show
    @user = User.find(params[:id])
    @user_id = @user.id
    @last_posts = @user.posts.order(created_at: :desc).limit(5)
    @tracks = @user.tracks.order(created_at: :asc).limit(15)
  end

  def recommendations
      @user = User.find(params[:id])
      @utracks = @user.tracks.map { |track| track.spotify_id }.sample(1)
      @recommendation = RSpotify::Recommendations.generate(seed_tracks: @utracks).tracks
      @recommendations = @recommendation.map { |track| track.uri }
      @data = @recommendations.join(',')
      @recommended_ids = @data.split(',').map { |item| item.split(':').last }
      @recommended_id = @recommended_ids.sample(5)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.favoritors
  end

  def following
    @user = User.find(params[:id])
    @following = @user.all_favorites.map(&:favoritable)
  end
end
