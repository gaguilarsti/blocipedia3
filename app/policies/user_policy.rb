class UserPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
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

  class Scope < Scope

     def resolve
       wikis = []
       all_wikis = Wiki.all
          all_wikis.each do |wiki|
            if wiki.user == @user || wiki.users.include?(@user)
              wikis << wiki
            end
          end
       wikis # return the wikis array we've built up
     end
   end


end
