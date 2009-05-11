module Tweetable

  def self.included(base)
    base.class_eval do
      after_create :make_tweet
      has_one :tweet, :as => :tweetable
      
      attr_accessor :should_tweet
    end
  end
  
  def to_tweet
    "#{title} #{url}"
  end
  
  def make_tweet
    if @should_tweet
      tweet = create_tweet(:body => to_tweet, :account => account)
      twitter_tweet = account.twitter_client.update(tweet.body, {})
      tweet.twitter_id = twitter_tweet.id
    end
  end

end
