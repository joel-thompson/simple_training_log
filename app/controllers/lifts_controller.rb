class LiftsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_lift_choice, only: [:new, :create]
  before_action :correct_user_lift, only: [:edit, :update, :destroy, :show]
  before_action :get_time_choices, only: [:new, :edit, :create]


  def index
    # not implemented
    redirect_to root_url
  end

  def new
    @lift = @lift_choice.lifts.new(
      occurred_date: Date.current,
      occurred_time: Entries.time_now
    )

    @previous_lift = @lift_choice.last_occurred
  end

  def create
    @lift = @lift_choice.lifts.new(lift_params)
    if @lift.save
      flash[:success] = "Saved!"
      redirect_to root_url
    else
      @previous_lift = @lift_choice.last_occurred
      render 'new'
    end
  end

  def edit
  end

  def update
    if @lift.update_attributes(lift_params)
      flash[:success] = "Saved!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @lift.destroy
    flash[:success] = "Deleted"
    redirect_to root_url
  end



  private def lift_params
    params.require(:lift).permit(
      :weight,
      :sets,
      :reps,
      :occurred_date,
      :occurred_time,
      :location,
      :notes
    )
  end

  private def correct_user_lift_choice
    @lift_choice = current_user.lift_choices.find_by(id: params[:lift_choice_id])
    redirect_to root_url if @lift_choice.nil?
  end

  private def correct_user_lift
    @lift = Lift.find(params[:id])
    redirect_to root_url unless @lift.user == current_user
    @lift_choice = @lift.lift_choice
  end

  private def get_time_choices
    @time_choices = Entries.times
  end


end
