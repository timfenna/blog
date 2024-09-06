class CommentsController < ApplicationController
  before_action :require_login, only: [ :destroy, :create ]
  def create
    @article = Article.find(params[:article_id])

    # Use for Turbo streams if not broadcasting
    # @comment = @article.comments.create(comment_params.merge({ user: current_user }))

    # Broadcasting the new comments
    @comment = @article.comments.new(comment_params.merge({ user: current_user }))

    if @comment.save
      Broadcast::Comment.append(comment: @comment)
    end
    # This seems to break the broadcasting
    # respond_to do |format|
    #   format.html { redirect_to article_comments_path }
    #   format.turbo_stream
    # end

    # redirect_to article_path(@article)
  end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = authorize @article.comments.find(params[:id])

    if @comment.destroy
      Broadcast::Comment.remove(comment: @comment)
    end

    #This is for the normal Turbo streams
    # @comment.destroy
    #
    # respond_to do |format|
    #   format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
    #   format.html { redirect_to article_comments_path }
    # end
    # redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
