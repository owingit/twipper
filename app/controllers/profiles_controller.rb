class ProfilesController < ApplicationController
	def new
		if current_user.profile
			redirect_to profile_path(current_user.profile)
		end
		@profile = Profile.new
	end
	def create
		@profile = Profile.new(profile_params)
		@profile.user = current_user
		if @profile.save
			flash[:success] = "Congratulations! You've successfully created your Twipper profile"
			redirect_to profile_path(current_user.profile)
		else 
			flash.now[:danger] = "Uh-oh! Something went wrong during profile creation"
			render 'new'
		end
		
	end

	def show
		@profile = Profile.find(params[:id])
	end

	def profile_params
		params.require(:profile).permit(:description, :pic)
	end
end
