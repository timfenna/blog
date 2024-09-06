class ArticlePolicy < ApplicationPolicy
  def show?
    is_visible?
  end

  def edit?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def create?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      visible?
    end

    private

    def visible?
      if user != nil
        scope.where(status: "public").or(scope.where(status: "private", user_id: user.id))
      else
        scope.where(status: "public")
      end
    end
  end
end
