class UserMailer < ApplicationMailer
  default from: "gama-aguilar@hotmail.com"

  def new_user(user)
    @user = user

    mail(to: user.email, cc: "gama-aguilar@hotmail.com", subject: "Welcome to Blocipedia!")
  end
end
