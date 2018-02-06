class LiftCalculationsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def result
    if params[:calculation] == 'plate'
      @barbell = Barbell.new(weight: params[:barbell_weight])
      render 'index' unless @barbell.valid?
    end
  end
end
