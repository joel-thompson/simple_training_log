class MartialArts::MartialArtsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy, :show]
  before_action :get_choices, only: [:new, :edit, :create]
  before_action :get_time_choices, only: [:new, :edit, :create]

  def index
    redirect_to root_url
  end

  def new
    @martial_art = MartialArts::MartialArt.new
  end

  def create
    @martial_art = current_user.martial_arts.new(martial_art_params)
    if @martial_art.save
      flash[:info] = "Saved!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @martial_art.destroy
    flash[:success] = "Deleted"
    redirect_back(fallback_location: root_url)
  end

  def show
  end

  def edit
  end

  def update
			# Update successful
		if @martial_art.update_attributes(martial_art_params)
			flash[:success] = "Martial art updated"
			redirect_to martial_art_path(@martial_art)

		else  # Update unsuccessful
			render 'edit'
		end
  end



  private

		def martial_art_params
      set_params_occurred_at_datetime
			params.require(:martial_art).permit(:type, :occurred_at, :notes)
		end

    def correct_user
      @martial_art = current_user.martial_arts.find_by(id: params[:id])
      redirect_to root_url if @martial_art.nil?
    end

    def get_choices
      @choices = MartialArts.choices
    end

    def get_time_choices
      @time_choices = Entries.times
    end

end
