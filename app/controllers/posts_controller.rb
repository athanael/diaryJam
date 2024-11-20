class PostsController < ApplicationController
  before_action :set_post, only: [:show, :like, :unlike]

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
      redirect_to posts_path, alert: @post.errors.full_messages.join(", ")
    end
  end

  def show

  end

  def like
    current_user.favorite(@post)
    if params[:from] == "index"
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end

  def unlike
    current_user.unfavorite(@post)
    if params[:from] == "index"
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :track_id, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
