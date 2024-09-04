require "test_helper"

class CommentTest < ActiveSupport::TestCase

  setup do
    @public_article = articles(:public_article)
  end

  test "should not save comment without body" do
    comment = @public_article.comments.new(
      status: "public"
    )
    assert_not comment.save
  end

  test "should not save comment without status" do
    comment = @public_article.comments.new(
      body: "this is the comment body"
    )
    assert_not comment.save
  end
end
