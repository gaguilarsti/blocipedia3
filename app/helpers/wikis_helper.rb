module WikisHelper
  def user_is_authorized_for_wikis?
    current_user
  end

  def body_preview(wiki)
    simple_format(wiki.body[0,250]+"...")
  end
end
