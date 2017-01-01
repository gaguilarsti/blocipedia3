class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
  end

  def downgrade
    current_user.wikis.each do |wiki|
      wiki.update_attributes!(private: false)
    end

    current_user.update_attribute(:role, 'standard')
    flash[:notice] = "You're account has been downgraded to a standard account."
    redirect_to wikis_path
  end


  # if @user.save
  #   flash[:notice] = "Welcome to Blocipedia #{@user.name}"
  #   redirect_to root_path
  # else
  #   flash.now[:alert] = "There was an error creating your account.  Please try again."
  #   render :new_user_registration
  # end

end
