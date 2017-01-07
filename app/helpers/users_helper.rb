module UsersHelper

  def user_has_wikis?(user)
    user.wikis.count > 0
  end

end
