class FunctionalThresholdPowerRecordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:destroy]
  
  def index
    #code
  end

  def create
    #code
  end

  def destroy
    #code
  end

  private def correct_user
    @record = current_user.functional_threshold_power_records.find_by(id: params[:id])
    redirect_to root_url if @record.nil?
  end
end
