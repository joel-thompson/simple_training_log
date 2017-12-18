class RoundsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_martial_art, only: [:new, :create]
  before_action :correct_user_round, only: [:edit, :update, :destroy, :show]

  def index
      # not implemented yet so just redirect
    redirect_to root_url
  end

  def new
    @round = @martial_art.rounds.new
  end

  def create
    @round = @martial_art.rounds.new(round_params)
    if @round.save
      flash[:success] = "Saved!"
      redirect_to martial_art_path(@martial_art)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @round.update_attributes(round_params)
      flash[:success] = "Saved!"
      redirect_to martial_art_path(@martial_art)
    else
      render 'new'
    end
  end

  def show
    redirect_to martial_art_path(@martial_art)
  end

  def destroy
    @round.destroy
    flash[:success] = "Deleted"
    redirect_to martial_art_path(@martial_art)
  end

  private def round_params
    params.require(:round).permit(:partner_name, :submissions, :notes)
  end

  private def correct_user_martial_art
    @martial_art = current_user.martial_arts.find_by(id: params[:martial_art_id])
    redirect_to root_url if @martial_art.nil?
  end

  private def correct_user_round
    @round = Round.find(params[:id])
    redirect_to root_url unless @round.user == current_user
    @martial_art = @round.martial_art
  end

end
