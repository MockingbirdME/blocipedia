class WikisController < ApplicationController

  skip_before_action :configure_permitted_parameters
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki successfully created"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error, wiki not created"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki successfully updated"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error, wiki not updated"
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki successfully deleted"
      redirect_to action: :index
    else
      flash.now[:alert] = "An error occured when attempting to delete wiki"
      render :show
    end
  end


  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end
end
