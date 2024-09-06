class ArticlesController < ApplicationController
  before_action :require_login
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = policy_scope(Article).all
  end

  def show
    authorize @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @user = User.find(current_user.id)
    @article = @user.articles.create(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def my_debugger
    # this is my own debugger method
    debugger
  end

  def set_article
    @article = authorize Article.find(params[:id])
  end
end
