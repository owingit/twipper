class TweetsController < ApplicationController
	def new
		@tweet = Tweet.new
		@tweets = Tweet.all
	end
	def create
		@tweet = Tweet.create(tweet_params)
		@tweets = Tweet.all
		flash[:success] = "Submission successful"
		render 'new'
	end

	def show
	end

	def tweet_params
		params.require(:tweet).permit(:tweet)
	end

end
