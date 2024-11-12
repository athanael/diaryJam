class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path, notice: "Post créé!"
    else
      #disply active record errors
      redirect_to root_path, alert: @post.errors.full_messages.join(", ")
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :track_id, :user_id)
  end
end
