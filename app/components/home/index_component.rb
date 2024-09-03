class Home::IndexComponent < ApplicationComponent
  def initialize(articles:)
    @articles = articles
  end
end
