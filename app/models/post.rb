class Post < ActiveRecord::Base  
  
  include Notifiable
  include Commentable
  include Tweetable
  
  belongs_to :author, :class_name => 'Account'  
  
  has_attached_file :photo, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  default_scope :order => 'created_at DESC'  
  
  alias :account :author
  
  def to_s
    title
  end
  
  def url
    "http://#{SITE_URL}/posts/#{id}"
  end
  
end
