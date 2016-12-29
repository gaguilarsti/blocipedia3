class ChargesPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    user.present? 
  end

end
