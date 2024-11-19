class PostsController < ApplicationController

  before_action :require_spotify_auth, only: [:index, :show]
  before_action :spotify_refresh_token
  def index
    @posts = Post.order(created_at: :desc).limit(10)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      #display active record errors
      redirect_to posts_path, alert: @post.errors.full_messages.join(", ")
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, :track_id, :user_id)
  end

end
