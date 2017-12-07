class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		@users = User.where(activated: true).paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated
	end


  def create
    outcome = Users::Signup.run(
      email: user_params[:email],
      name: user_params[:name],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
    )
    if outcome.success?
      @user = outcome.result
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      # this allows me to have additional signup validations in the command, then display them to the user's form. while also not losing the users inputs
      @user = User.new(user_params)
      @user.errors.add_mutation_errors(outcome.errors)
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

	def destroy
	  User.find(params[:id]).destroy
		flash[:success] = "User deleted" # could add a check for the user actually deleted
		redirect_to users_url
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password,
		                           :password_confirmation)
		end


  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_url) unless current_user?(@user)
  	end

  		# Confirms an admin user.
  	def admin_user
  		redirect_to(root_url) unless  current_user && current_user.admin?
  	end

end
