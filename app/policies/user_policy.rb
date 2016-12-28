class UserPolicy < ApplicationPolicy

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create
    user.present?
  end

  def new
    user.present?
  end

  def update
    user.present?
  end

  def edit
    user.present
  end

end
