class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @activities = @user.activity_feed
    @tracks = @user.tracks
  end
end
