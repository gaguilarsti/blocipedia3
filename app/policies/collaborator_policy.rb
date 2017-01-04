class CollaboratorPolicy < ApplicationPolicy
  def create?
    user.present? && (@wiki.user == user) && (@user.role == "premium" || @user.role == "admin")
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
