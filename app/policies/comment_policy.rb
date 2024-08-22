class CommentPolicy < ApplicationPolicy

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      visible?
    end

    private

    def visible?
      scope.where(status: "public").or(scope.where(status: "private", user_id: user.id))
    end
  end

end
