class BodyWeightRecordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:destroy]

  def index
    @records = BodyWeightRecordDecorator.decorate_collection(current_user.body_weight_records.order(weighed_at: :desc).paginate(page: params[:page]))
    @user = current_user.decorate
  end

  def create
    @record = current_user.update_weight(params[:weight])
    if @record.valid?
      record_intercom_event('Updated Body Weight')
      flash[:success] = "Saved!"
      redirect_to root_url
    else
      flash[:danger] = "Unable to save."
      redirect_to root_url
    end
  end

  def destroy
    record_intercom_event('Deleted Body Weight Record')
    @record.destroy
    flash[:success] = "Deleted"
    redirect_back(fallback_location: root_url)
  end

  private def correct_user
    @record = current_user.body_weight_records.find_by(id: params[:id])
    redirect_to root_url if @record.nil?
  end

  private def record_intercom_event(name)
    RecordIntercomEventWorker.perform_async(
      current_user.id,
      name,
      { weight: @record.weight },
      Time.now.to_i,
    )
  end

end
