require 'test_helper'

class ArticlePolicyTest < ActiveSupport::TestCase

  setup do
    @author_of_private_article = users(:author_of_private_article)
    @author_of_public_article = users(:author_of_public_article)
    @user_who_is_not_an_author = users(:user_who_is_not_an_author)
    @public_article = articles(:public_article)
    @private_article = articles(:private_article)
  end

  test "should show public article for user who is not the author" do
    assert ArticlePolicy.new(@user_who_is_not_an_author, @public_article).show?
  end

  test "should allow the author to edit a public article" do
    assert ArticlePolicy.new(@author_of_public_article, @public_article).edit?
  end

  test "should not allow a user to edit a public article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @public_article).edit?
  end

  test "should allow the author to update a public article" do
    assert ArticlePolicy.new(@author_of_public_article, @public_article).update?
  end

  test "should not allow a user to update a public article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @public_article).update?
  end

  test "should allow the author to destroy a public article" do
    assert ArticlePolicy.new(@author_of_public_article, @public_article).destroy?
  end

  test "should not allow a user to destroy a public article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @public_article).destroy?
  end

  test "should show private article for user who is the author" do
    assert ArticlePolicy.new(@author_of_private_article, @private_article).show?
  end

  test "should not show private article for user who is not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @private_article).show?
  end

  test "should allow the author to edit a private article" do
    assert ArticlePolicy.new(@author_of_private_article, @private_article).edit?
  end

  test "should not allow a user to edit a private article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @private_article).edit?
  end

  test "should allow the author to update a private article" do
    assert ArticlePolicy.new(@author_of_private_article, @private_article).update?
  end

  test "should not allow a user to update a private article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @private_article).update?
  end

  test "should allow the author to destroy a private article" do
    assert ArticlePolicy.new(@author_of_private_article, @private_article).destroy?
  end

  test "should not allow a user to destroy a private article if they are not the author" do
    assert_not ArticlePolicy.new(@user_who_is_not_an_author, @private_article).destroy?
  end

  test "should get private articles written by the user" do
    scoped_articles = ArticlePolicy::Scope.new(@author_of_private_article, Article.where(id: @private_article))
    assert_equal([ @private_article ], scoped_articles.resolve)
  end

  test "should not get private articles if the user is not the author" do
    scoped_articles = ArticlePolicy::Scope.new(@user_who_is_not_an_author, Article.where(id: @private_article))
    assert_not_equal([ @private_article ], scoped_articles.resolve)
  end
end
