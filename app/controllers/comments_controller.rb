class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Commentaire ajouté !"
    else
      redirect_to post_path(@post), alert: "Erreur lors de l'ajout du commentaire"
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    redirect_to post_path(@comment.post), notice: "Commentaire supprimé !"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
