class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  require 'will_paginate/array'

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # my form pattern date time handler
  # assumes:
  # params = {model: {date: {occurred_at: '2017-6-7'} time: {occurred_at: 'now'}}}
  # then sets occurred_at, and clears the others so I don't get false positive require warnings
  def set_params_occurred_at_datetime

    # quits with nil if there's something unexpected, model would then just set the datetime to now which is fine for now.
    return nil if !params[controller_name.singularize.to_sym].present?

    date = params.try(:[], controller_name.singularize.to_sym).try(:[], :date).try(:[], :occurred_at)
    time = params.try(:[], controller_name.singularize.to_sym).try(:[], :time).try(:[], :occurred_at)
    occurred_at_datetime = Entries.date_and_time_handler(
      date,
      time
    )
    params[controller_name.singularize.to_sym][:occurred_at] = occurred_at_datetime
    params[controller_name.singularize.to_sym].delete(:date)
    params[controller_name.singularize.to_sym].delete(:time)
  end

end
