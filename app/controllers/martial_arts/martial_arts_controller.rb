class MartialArts::MartialArtsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy, :show]
  before_action :get_choices, only: [:new, :edit, :create]
  before_action :get_time_choices, only: [:new, :edit, :create]

  def index
    redirect_to root_url
  end

  def new
    @martial_art = MartialArts::MartialArt.new(
      occurred_date: Date.current.to_s,
      occurred_time: Entries.time_now
    )
  end

  def create
    @martial_art = current_user.martial_arts.new(martial_art_params)
    if @martial_art.save
      flash[:success] = "Saved!"
      redirect_to martial_art_path(@martial_art)
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
    @techniques = @martial_art.techniques
    @rounds = @martial_art.rounds
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
      if params[:martial_art].present?
        if params[:martial_art][:duration_in_minutes].present?
          params[:martial_art][:duration_in_seconds] = params[:martial_art][:duration_in_minutes].to_i * 60
        end
      end

      params.require(:martial_art).permit(
        :type,
        :occurred_time,
        :occurred_date,
        :notes,
        :duration_in_seconds,
        :goal,
        :goal_result,
        :location
      )
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
