class PostsController < ApplicationController

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

  private

  def post_params
    params.require(:post).permit(:content, :track_id, :user_id)
  end
end
