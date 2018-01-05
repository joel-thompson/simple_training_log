class WelcomeController < ApplicationController
  def index
    if logged_in?
      @feed_items = current_user.all_entries.paginate(page: params[:page])
      @lift_choices = current_user.lift_choices
    end
  end
end
