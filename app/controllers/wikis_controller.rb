class WikisController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]


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

  def authorize_user
    @wiki = Wiki.find(params[:id])
    unless current_user == @wiki.user || current_user.admin?
      flash[:alert] = "You don't have permissions to do that."
      redirect_to @wiki
    end
  end

end
