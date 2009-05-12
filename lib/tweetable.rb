module Tweetable

  def self.included(base)
    base.class_eval do
      after_create :make_tweet
      has_one :tweet, :as => :tweetable, :dependent => :destroy
      
      attr_accessor :should_tweet
    end
  end
  
  def to_tweet
    if tag_list.empty?
      return "#{to_s} #{url}"
    else
      tag_list_to_s = ''
      tag_list.each do { |tag| tag_list_to_s << '#' + tag.name }
      return "#{to_s} #{url} #{tag_list_to_s}"
    end
  end
  
  def make_tweet
    if should_tweet
      tweet!
    end
  end
  
  def tweet!
    create_tweet(:body => to_tweet, :account => account)
  end
  
  def tweeted?
    tweet != nil
  end

end
