class CardiosController < ApplicationController
    before_action :logged_in_user
    before_action :correct_user_cardio_choice, only: [:new, :create]
    before_action :correct_user_cardio, only: [:edit, :update, :destroy, :show]
    before_action :get_time_choices, only: [:new, :edit, :create]

    def index
      # not implemented
      redirect_to root_url
    end

    def new
      @cardio = @cardio_choice.cardios.new(
        occurred_date: Date.current,
        occurred_time: Entries.time_now
      )

      @previous_cardio = @cardio_choice.last_occurred
    end

    def create
      @cardio = @cardio_choice.cardios.new(cardio_params)
      if @cardio.save
        flash[:success] = "Saved!"
        redirect_to root_url
      else
        @previous_cardio = @cardio_choice.last_occurred
        render 'new'
      end
    end

    def edit
    end

    def update
      if @cardio.update_attributes(cardio_params)
        flash[:success] = "Saved!"
        redirect_to root_url
      else
        render 'new'
      end
    end

    def show
    end

    def destroy
      @cardio.destroy
      flash[:success] = "Deleted"
      redirect_to root_url
    end

    private def cardio_params
      if params[:cardio].present?
        if params[:cardio][:duration_in_minutes].present?
          params[:cardio][:duration_in_seconds] = params[:cardio][:duration_in_minutes].to_i * 60
        end
      end

      params.require(:cardio).permit(
        :duration_in_seconds,
        :occurred_date,
        :occurred_time,
        :notes
      )
    end

    private def correct_user_cardio_choice
      @cardio_choice = current_user.cardio_choices.find_by(id: params[:cardio_choice_id])
      redirect_to root_url if @cardio_choice.nil?
    end

    private def correct_user_cardio
      @cardio = Cardio.find(params[:id])
      redirect_to root_url unless @cardio.user == current_user
      @cardio_choice = @cardio.cardio_choice
    end

    private def get_time_choices
      @time_choices = Entries.times
    end
end
