module Tweetable

  def self.included(base)
    base.class_eval do
      after_create :make_tweet
      has_one :tweet, :as => :tweetable, :dependent => :destroy
      
      attr_accessor :should_tweet
    end
  end
  
  def make_tweet
    if should_tweet
      tweet!
    end
  end
  
  def tweet!
    create_tweet(:body => to_tweet, :account => account, :tag_list => tag_list)
  end
  
  def tweeted?
    tweet != nil
  end
  
  def to_tweet
    "#{to_tweet_body} #{to_tweet_tags}#{to_tweet_url}"
  end
  
  def to_tweet_body
    to_s
  end
  
  def to_tweet_tags
    tag_list_to_s = ''
    tag_list.each { |tag| tag_list_to_s << "##{tag} " }
    return tag_list_to_s
  end
  
  def to_tweet_url
    url
  end

end
