require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new(
      body: "This is the article body",
      status: "public"
    )
    assert_not article.save, "Saved the article without a title"
  end

  test "should not save article without body" do
    article = Article.new(
      title: "This is the article title",
      status: "public"
    )
    assert_not article.save, "Saved the article without a body"
  end

  test "should not save article without status" do
    article = Article.new(
      title: "This is the article title",
      body: "This is the article body"
    )
    assert_not article.save, "Saved the article without a status"
  end
end
