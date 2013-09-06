class AlbumsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_user, only: [:edit,:show,:update]

  def check_user
    if current_user != Album.find(params[:id]).user
      flash[:alert] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
  
  
  def index
    @albums = Album.where(:user_id => current_user.id)

    respond_to do |format|
      format.html 
      format.json { render json: @albums }
    end
  end

  
  
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @album }
    end
  end

  
  
  def new
    @album = Album.new

    respond_to do |format|
      format.html 
      format.json { render json: @album }
    end
  end

  
  def edit
    @album = Album.find(params[:id])
  end

  
  
  def create
    @album = Album.new(params[:album])
    @album.user_id = current_user.id
    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  
  
  def update
    debugger
    @album = Album.find(params[:id])
    debugger

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
