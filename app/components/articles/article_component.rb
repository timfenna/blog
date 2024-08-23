class Articles::ArticleComponent < ApplicationComponent
  def initialize(article:)
    @article = article
  end
end
