class LiftChoicesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @lift_choices = current_user.lift_choices
  end

  def new
    @lift_choice = current_user.lift_choices.build(
      has_weight: true
    )
  end

  def create
    @lift_choice = current_user.lift_choices.build(lift_choice_params)
    if @lift_choice.save
      flash[:success] = "Saved!"
      redirect_to lift_choices_path
    else
      render 'new'
    end
  end

  def edit
    @lifts = @lift_choice.lifts.to_a.flatten
    Entries.sort_by_occurred!(@lifts)
  end

  def update
    if @lift_choice.update_attributes(lift_choice_params)
			flash[:success] = "Lift choice updated"
			redirect_to lift_choices_path
		else
			render 'edit'
    end
  end

  def destroy
    @lift_choice.destroy
    flash[:success] = "Deleted"
    redirect_to lift_choices_path
  end

  private def lift_choice_params
    params.require(:lift_choice).permit(
      :name,
      :has_weight,
      :default_reps,
      :default_sets
    )
  end

  private def correct_user
    @lift_choice = current_user.lift_choices.find_by(id: params[:id])
    redirect_to root_url if @lift_choice.nil?
  end

end
