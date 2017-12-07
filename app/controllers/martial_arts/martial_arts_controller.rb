class MartialArts::MartialArtsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy, :show]

  def index
    redirect_to root_url
  end

  def new
    @martial_art = MartialArts::MartialArt.new
    @choices = MartialArts.choices
  end

  def create
    outcome = MartialArts::Create.run(
      user: current_user,
      type: martial_art_params[:type],
      occurred_at: occured_at_datetime,
      notes: martial_art_params[:notes]
    )
    if outcome.success?
      @martial_art = outcome.result
      flash[:info] = "Saved!"
      redirect_to root_url
    else
      # this allows me to have additional signup validations in the command, then display them to the user's form. while also not losing the users inputs
      @martial_art = MartialArts::MartialArt.new(martial_art_params)
      @martial_art.errors.add_mutation_errors(outcome.errors)
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
    @choices = MartialArts.choices
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

end
