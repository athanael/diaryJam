class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @last_posts = @user.posts.order(created_at: :desc).limit(5)
    @tracks = @user.tracks.order(created_at: :desc).limit(10)
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
