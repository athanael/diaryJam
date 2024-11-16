class TracksController < ApplicationController
  def search
    @user = current_user
    @search = params[:query]

    if @search.present?
      @found_tracks = @user.tracks.where("title ILIKE ? OR artist ILIKE ?", "%#{@search}%", "%#{@search}%")
    else
      @found_tracks = []
    end

    render json: @found_tracks.pluck(:id, :artist, :title)
  end
end
