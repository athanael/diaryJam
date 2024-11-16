class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @last_posts = @user.posts.last(5)
    @tracks = @user.tracks
  end
end
