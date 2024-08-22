class CommentsController < ApplicationController
  before_action :require_login, only: [ :destroy, :create ]
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params.merge({ user: current_user }))
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
