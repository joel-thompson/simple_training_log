class TechniquesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_martial_art, only: [:new, :create]
  before_action :correct_user_technique, only: [:edit, :update, :destroy, :show]

  def index
      # not implemented yet so just redirect
    redirect_to root_url
  end

  def new
    @technique = @martial_art.techniques.new
  end

  def create
    @technique = @martial_art.techniques.new(technique_params)
    if @technique.save
      flash[:success] = "Saved!"
      redirect_to martial_art_path(@martial_art)
    else
      # flash[:danger] = "Could not save the technique."
      render 'new'
    end
  end

  def edit
    #code
  end

  def update
    if @technique.update_attributes(technique_params)
      flash[:success] = "Saved!"
      redirect_to martial_art_path(@martial_art)
    else
      # flash[:danger] = "Could not save the technique."
      render 'new'
    end
  end

  def show
    redirect_to martial_art_path(@martial_art)
  end

  def destroy
    @technique.destroy
    flash[:success] = "Deleted"
    redirect_to martial_art_path(@martial_art)
  end



  private def technique_params
    params.require(:technique).permit(:name, :details, :notes)
  end

  private def correct_user_martial_art
    @martial_art = current_user.martial_arts.find_by(id: params[:martial_art_id])
    redirect_to root_url if @martial_art.nil?
  end

  private def correct_user_technique
    @technique = Technique.find(params[:id])
    redirect_to root_url unless @technique.user == current_user
    @martial_art = @technique.martial_art
  end

end
