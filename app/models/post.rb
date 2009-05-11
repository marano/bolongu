class Post < ActiveRecord::Base  
  
  include Notifiable
  include Commentable
  
  before_create :make_url
  after_create :make_tweet
  
  belongs_to :author, :class_name => 'Account'
  has_one :tweet, :as => :tweetable    
  
  has_attached_file :photo, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  default_scope :order => 'created_at DESC'
  
  attr_accessor :should_tweet
  
  alias :account :author
  
  def make_url
    if new_record?
      url = "http://#{SITE_URL}/posts/#{id}"
    else
      update_attributes :url => "http://#{SITE_URL}/posts/#{id}"
    end
  end
  
  def to_tweet
    "#{title} - #{url}"
  end
  
  def make_tweet
    if @should_tweet
      tweet = create_tweet(:body => to_tweet, :account => author)
      twitter_tweet = account.twitter_client.update(tweet.body, {})
      tweet.twitter_id = twitter_tweet.id
    end
  end
  
end
