class HashtagsController < ApplicationController
	def show
		@hashtag = Hashtag.where(h: params[:hash_tag_id]).first
		@tweets = Tweet.all 

		@filtered_tweets = @tweets.select {|t| t.extract_hash_tags.include?(@hashtag.h) }#whatever goes here keep it
	end

end
