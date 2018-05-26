class CardioChoicesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy]


  def index
    @cardio_choices = current_user.cardio_choices
  end

  def new
    @cardio_choice = current_user.cardio_choices.build
  end

  def create
    @cardio_choice = current_user.cardio_choices.build(cardio_choice_params)
    if @cardio_choice.save
      flash[:success] = "Saved!"
      redirect_to cardio_choices_path
    else
      render 'new'
    end
  end

  def edit
    @cardios = @cardio_choice.cardios.to_a.flatten
    Entries.sort_by_occurred!(@cardios)
  end

  def update
    if @cardio_choice.update_attributes(cardio_choice_params)
      flash[:success] = "cardio choice updated"
      redirect_to cardio_choices_path
    else
      render 'edit'
    end
  end

  def destroy
    @cardio_choice.destroy
    flash[:success] = "Deleted"
    redirect_to cardio_choices_path
  end


  private def cardio_choice_params
    params.require(:cardio_choice).permit(
      :name
    )
  end

  private def correct_user
    @cardio_choice = current_user.cardio_choices.find_by(id: params[:id])
    redirect_to root_url if @cardio_choice.nil?
  end

end
