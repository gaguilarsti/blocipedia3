class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @wiki
    else
      flash[:error] = "Error. Please try again."
      render :show
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @wiki
    else
      flash[:error] = "Error. Please try again."
      render :show
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
