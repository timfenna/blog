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
end
