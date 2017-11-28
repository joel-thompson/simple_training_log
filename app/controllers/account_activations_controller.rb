class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])

      #TODO make a method called activate which does both lines below
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  def new
    user = User.find_by(email: params[:email])
    user.resend_activation_email
    message  = "Invitation link sent"
    flash[:info] = message
    redirect_to login_url
  end

end
