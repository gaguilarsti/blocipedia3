class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    if @wiki.private?
      @wiki.user == user || user.admin?
    else
      @user.present?
    end
  end

  def index?
    true
  end

  def create?
    @user.present?
  end

  def new?
    create?
  end

  def update?
    if @wiki.private?
      @user.premium? || @user == @wiki.user || user.admin?
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

  def add_collaborator?
    @user.premium? || @user.admin? || @wiki.user == user
  end

  def remove_collaborator?
    add_collaborator?
  end

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       wikis = []
      #  if user.role == 'admin'
      #    wikis = scope.all # if the user is an admin, show them all the wikis
       if !user.present?
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki.private?
             wikis << wiki # if the user is not signed in (e.g. guest), show them only public wikis
           end
         end
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       elsif # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       else
         wikis = scope.all
       end
       wikis # return the wikis array we've built up
     end
   end

end
