class MartialArts::MartialArtsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy, :show]
  before_action :get_choices, only: [:new, :edit, :create]

  def index
    redirect_to root_url
  end

  def new
    @martial_art = MartialArts::MartialArt.new

  end

  def create
    @martial_art = current_user.martial_arts.new(
      type: martial_art_params[:type],
      notes: martial_art_params[:notes],
      occurred_at: occured_at_datetime
    )
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
    #code
  end

  def edit
    #code
    # @choices = MartialArts.choices
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
			params.require(:martial_art).permit(:type, :occurred_at, :notes)
		end

    def correct_user
      @martial_art = current_user.martial_arts.find_by(id: params[:id])
      redirect_to root_url if @martial_art.nil?
    end

    def occured_at_datetime
      return nil unless martial_art_params["occurred_at(1i)"].present? &&
                        martial_art_params["occurred_at(2i)"].present? &&
                        martial_art_params["occurred_at(3i)"].present?

      str = martial_art_params["occurred_at(1i)"]
      str += "-" + martial_art_params["occurred_at(2i)"]
      str += "-" + martial_art_params["occurred_at(3i)"]

      time_now_string_array = Time.zone.now.to_s.split(" ")

      str += " " + time_now_string_array[1]
      str += " " + time_now_string_array[2]

      DateTime.parse(str)
    end

    def get_choices
      @choices = MartialArts.choices
    end

end
