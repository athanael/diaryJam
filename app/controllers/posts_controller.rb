class PostsController < ApplicationController

  def index
    @posts = Post.followers_posts(current_user.followers_id, current_user)
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
