class Bookmark < ActiveRecord::Base

  include Notifiable
  include Commentable
  include Tweetable

  belongs_to :publisher, :class_name => 'Account'
  after_create :make_thumbs
  
  default_scope :order => 'created_at DESC'
  
  has_attached_file :screen, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  has_attached_file :screen_excerpt, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
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
  
  def make_thumbs
    #Thread.new do
      t = Nailer.new(adress)
      t.wait_until_ready
      
      screen_file = Tempfile.new('screen')
      screen_file << t.retrieve(:large)      
      
      screen_excerpt_file = Tempfile.new('screen_excerpt')
      screen_excerpt_file << t.retrieve(:excerpt)
      
      b = Bookmark.find(id)
      
      b.screen = screen_file
      b.screen_excerpt = screen_excerpt_file
      
      b.save
    #end
  end
end
