module Broadcast
  class Comment
    def self.append(comment:)
      new(comment).append
    end

    def self.remove(comment:)
      new(comment).remove
    end

    def initialize(comment)
      @comment = comment
    end

    def append
      Turbo::StreamsChannel.broadcast_append_later_to(
        :comments,
      target: "comments",
        html: rendered_component
      )
    end

    def remove
      Turbo::StreamsChannel.broadcast_remove_to(
      :comments,
      target: "comment_#{@comment.id}"
      )
    end

    private

    attr_reader :comment

    def rendered_component
      ApplicationController.render(
        Comments::CommentComponent.new(comment: comment),
        layout: false
      )
    end

  end
end