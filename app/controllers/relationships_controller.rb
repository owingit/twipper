class RelationshipsController < ApplicationController
	def create
		@relationship = Relationship.new(relationship_params)
		@relationship.follower_id = current_user

		current_user.follow(User.find(@relationship.followed_id))

		if @relationship.save
			flash[:success] = "You are now following #{User.find(@relationship.followed_id).email}"
		else 
			flash[:danger] = "The user ha taken out a restraining order against you and you may not follow them at the present moment"
		end
		#create is permanent

		redirect_to tweets_path
	end

	def destroy
		@user = User.find(relationship_params[:followed_id])
		if current_user.following?(@user)
			flash[:info] = "You are no longer following #{@user.email}"
			current_user.unfollow(@user)
		end
		redirect_to tweets_path
	end

	def relationship_params
		params.require(:relationship).permit(:followed_id)
	end
end
