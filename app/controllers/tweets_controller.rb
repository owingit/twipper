class TweetsController < ApplicationController
	before_action :authenticate_user!
	def new
		@tweet = Tweet.new
		@tweets = current_user.tweets
	end
	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user
		if @tweet.save
			flash[:success] = "Submission successful"
		else 
			flash[:danger] = "Something went wrong. Something went horribly, horribly wrong."
		#@tweet = Tweet.create(tweet_params)
		end
		@tweets = current_user.tweets
		render 'new'
	end

	def index
		@tweets = Tweet.all.reject {|tweet| tweet.user == current_user}
	end

	def tweet_params
		params.require(:tweet).permit(:tweet)
	end

end
