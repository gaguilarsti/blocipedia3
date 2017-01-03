class WikisController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  after_action :clear_collaborators, only: :update # removes collaborators if wiki is made public

  def index
    #only show private wikis to those that are admins or premium users
    @wikis = policy_scope(Wiki)

  end

  def show
    #anyone can see an indvidual wiki
    @wiki = Wiki.find(params[:id])

    authorize @wiki
  end

  def new
    #only logged in users can create wikis
    @wiki = Wiki.new
    authorize Wiki
  end

  def create
    #only logged in users can create wikis
    # @wiki = Wiki.new
    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]
    # @wiki.user = current_user
    # @wiki.private = params[:wiki][:private]

    @wiki = Wiki.new(wiki_params)

    # assign to properly scope the new wiki.
    @wiki.user = current_user


    authorize Wiki

    if @wiki.save
      flash[:notice] = "Wiki was successfully created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating your wiki.  Please try again."
      render :new
    end
  end

  def edit
    #only logged in users can edit wikis
    @wiki = Wiki.find(params[:id])

    @users = User.all

    authorize @wiki
  end

  def update
    # only logged in users can update wikis
    # @wiki = Wiki.find(params[:id])
    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]
    # @wiki.private = params[:wiki][:private]

    @wiki = Wiki.find(params[:id])

    @wiki.assign_attributes(wiki_params)

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating your wiki.  Please try again."
      render :edit
    end
  end

  def add_collaborator
    authorize :wiki, :add_collaborator?

    #find the user that you want to add as a collaborator's email because people will add collaborators as via their email address.
    user_email = params[:email]
    #find the user_id for that collaborator
    user_id = User.where(email: user_email).pluck(:id)
    #referenc the user by their user id.
    user = User.where(id: user_id)
    #find the wiki in which you'll be adding collaborators
    @wiki = Wiki.find(params[:id])

    if !user.exists? #if the user does not exists
      flash[:alert] = "That user doesn't exist, try adding a different user"
    elsif @wiki.collaborators.where(id: user).exists? #if the user is already a collaborator on the wiki
      flash[:alert] = "#{user.name} is already a collaborator on this wiki."
    else
      @wiki.collaborators << user # add the user to collaborators table
      flash[:notice] = "#{user.name} was successfully added as a collaborator to this wiki!"
    end

    redirect_to @wiki
  end

  def remove_collaborator
    authorize :wiki, :remove_collaborator?

    #find the wiki to remove the collaborator
    @wiki = Wiki.find(params[:id])

    #I don't get this - shouldn't we need to get the collaborator to be removed via their email?
    collaborator_id = params[:collaborator_id]

    collaborator_user_id = @wiki.collaborators.where(id: user).pluck(:id)

    collaborator = User.where(id: collaborator_user_id)

    #remove user from wiki.collaborators array
    @wiki.collaborators.delete(collaborator_id)
    flash[:notice] = "#{collaborator.name} has been removed as a collaborator on this wiki."

    redirect_to @wiki

  end

  def destroy
    #only the wiki owner or admin can delete wikis
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the Wiki.  Please try again."
      render :show
      redirect_to @wiki
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def clear_collaborators
    @wiki = Wiki.find(params[:id])
    if !@wiki.private?
      @wiki.collaborators.clear 
    end

  end

  def authorize_user
    @wiki = Wiki.find(params[:id])
    unless current_user == @wiki.user || current_user.admin?
      flash[:alert] = "You don't have permissions to do that."
      redirect_to @wiki
    end
  end

end
