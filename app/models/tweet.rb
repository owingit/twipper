class Tweet < ActiveRecord::Base
	include Twitter::Extractor

	def extract_hash_tags
		extract_hashtags(self.tweet)
	end

	validate "hashtags_created" #custom validation waits for you to call an error

	def hashtags_created
		begin
			transaction do
				@hashtags = self.extract_hash_tags
				@hashtags.each do |the_hashtag|
					if Hashtag.where(h: the_hashtag).any?
						#do nothing --> .where h is the hashtag in question
					else
						if Hashtag.create!(h: the_hashtag)
							#do nothing
						else self.errors.add(:tweet, "The hashtag is not valid")
						end
					end
				end
			end
		rescue
			self.errors.add(:tweet, "The hashtag is not valid")
		end
	end			
			

	belongs_to :user
	validates :tweet, length: { maximum: 140 }

	##tweet's intrinsic nature
end
