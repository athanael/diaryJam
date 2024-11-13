class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @activities = @user.activity_feed
    @tracks = [
      OpenStruct.new(title: "Rick Roll", artist: "Rick Astley"),
      OpenStruct.new(title: "Blinding Lights", artist: "The Weeknd"),
      OpenStruct.new(title: "2 SEC", artist: "Realo"),
      OpenStruct.new(title: "save;File=9", artist: "kuru"),
      OpenStruct.new(title: "SISTERHOOD (LOVE, HER.)", artist: "Lucy Bedroque")
    ]
  end
end
