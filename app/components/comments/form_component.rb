class Comments::FormComponent < ApplicationComponent
  def initialize(article:)
    @article = article
  end
end
