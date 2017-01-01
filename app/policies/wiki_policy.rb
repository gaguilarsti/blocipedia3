class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  #only premium
  def show?
    if @wiki.private?
      @wiki.user == user || user.admin
    else
      @user.present?
    end
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
    if @wiki.private?
      @user == @wiki.user || user.admin
    else
      @user.present?
    end
  end

  def edit?
    update?
  end

  def destroy?
    # only the wiki owner or an admin can delete a wiki
    @user.role == "admin" || @wiki.user == user
  end

end
