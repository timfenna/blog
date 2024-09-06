require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @public_article = articles(:public_article)
    @private_article = articles(:private_article)
    @author_of_private_article = users(:author_of_private_article)
    @author_of_public_article = users(:author_of_public_article)
    @user_who_is_not_an_author = users(:user_who_is_not_an_author)
    @article_params = {
      article: {
        title: "article title",
        body: "article body",
        status: "public"
      }
    }
  end

  test "should get index when signed in" do
    get articles_url(as: @author_of_private_article)
    assert_response :success
  end

  test "should get new when signed in" do
    get new_article_url(as: @author_of_private_article)
    assert_response :success
  end

  test "should create article when signed in" do
    assert_difference("Article.count") do
      post articles_url(as: @author_of_public_article), params: @article_params
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article when signed in as author" do
    get article_url(@public_article, as: @author_of_public_article)
    assert_response :success
  end

  test "should get edit when signed in as author" do
    get edit_article_url(@public_article, as: @author_of_public_article)
    assert_response :success
  end

  test "should update public article when signed in as author" do
    patch article_url(@public_article, as: @author_of_public_article), params: @article_params
    assert_redirected_to article_url(@public_article)
  end

  test "should destroy article when signed in as author" do
    assert_difference("Article.count", -1) do
      delete article_url(@public_article, as: @author_of_public_article)
    end
    assert_redirected_to articles_url
  end

  test "should not destroy article when signed in as user who is not the author" do
    initial_count = Article.count
    delete article_url(@public_article, as: @user_who_is_not_an_author)
    count_after_destroy = Article.count
    assert_equal(initial_count, count_after_destroy)
    assert_redirected_to root_path
  end
end
