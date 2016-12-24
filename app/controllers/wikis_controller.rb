class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was successfully created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating your wiki.  Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating your wiki.  Please try again."
      render :edit
    end
  end

  def destroy
  @wiki = Wiki.find(params[:id])

  if @wiki.destroy
    redirect_to wikis_path, notice: "\"#{@wiki.title}\" was deleted successfully."
  else
    flash.now[:alert] = "There was an error deleting the Wiki.  Please try again."
    render :show
  end
end


end
