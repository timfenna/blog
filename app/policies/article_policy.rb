# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  def update?
    user.id == record.user.id
  end
end
