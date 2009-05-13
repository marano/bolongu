class Bookmark < ActiveRecord::Base

  include Notifiable
  include Commentable
  include Tweetable

  belongs_to :publisher, :class_name => 'Account'
  
  default_scope :order => 'created_at DESC'  
  
  alias :account :publisher
  
  def to_s
    title
  end
  
  def to_tweet_url
    adress
  end
  
  def url
    "http://#{SITE_URL}/bookmarks/#{id}"
  end
end
