class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @last_posts = @user.posts.order(created_at: :desc).limit(5)
    @tracks = @user.tracks.order(created_at: :desc).limit(10)
  end

  def recommendations
    @user = User.find(params[:id])
    @recommendation = RSpotify::Recommendations.generate(seed_tracks: @user.tracks.map(&:spotify_id)).tracks
    @recommendations = @recommendation.map { |track| track.uri }
    @data = @recommendations.join(',')
    @recommended_ids = @data.split(',').map { |item| item.split(':').last }
    @recommended_id = @recommended_ids.sample
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
