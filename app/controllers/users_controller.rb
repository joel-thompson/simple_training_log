class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]

	def index
	  # @users = User.all
		@users = User.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# handle successful save
			log_in @user
			flash[:success] = "Welcome to Logging Progress!"
			redirect_to @user
		else
			# handle failed save
			render 'new'
		end
	end

	def edit
	  @user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

			# Update successful
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user

		else  # Update unsuccessful
			render 'edit'
		end
	end

	# def destroy
	#   @user = User.find(params[:id])
	# 	@user.destroy
	# 	redirect_to root_url
	# end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password,
		                           :password_confirmation)
		end

		def logged_in_user
      unless logged_in?
				store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
		end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

end
