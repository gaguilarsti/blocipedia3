class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # def index?
  #   @user.present?
  # end

  def create?
    @user.present?
  end

  def new?
    create?
  end

  def update?
    #allows anyone to edit a public Wiki
    @user.present?
  end

  def edit?
    update?
  end

  def destroy?
    # only the wiki owner or an admin can delete a wiki
    @user.admin?
  end

end
