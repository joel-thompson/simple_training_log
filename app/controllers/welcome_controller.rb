class WelcomeController < ApplicationController
  def index
    if logged_in?
      @feed_items = current_user.all_entries.paginate(page: params[:page], per_page: 10)
      @lift_choices = current_user.lift_choices
      @cardio_choices = current_user.cardio_choices
      @current_program = current_user&.active_training_program&.decorate
    end
  end
end
