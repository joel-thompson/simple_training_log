class WelcomeController < ApplicationController
  def index
    if logged_in?
      @feed_items = current_user.all_entries.paginate(page: params[:page])
    end
  end
end
