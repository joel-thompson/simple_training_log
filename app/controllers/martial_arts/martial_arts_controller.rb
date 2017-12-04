class MartialArts::MartialArtsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update]

  def new
    @martial_art = MartialArts::MartialArt.new
    @choices = MartialArts.choices
  end

  def create
    outcome = MartialArts::Create.run(
      user: current_user,
      type: martial_art_params[:type],
      occurred_at: martial_art_params[:occurred_at],
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



  private

		def martial_art_params
			params.require(:martial_art).permit(:type, :occurred_at, :notes)
		end

    def correct_user
      @martial_art = current_user.martial_arts.find_by(id: params[:id])
      redirect_to root_url if @martial_art.nil?
    end

end
