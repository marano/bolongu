class Post < ActiveRecord::Base
  
  after_create :notify!
  after_save :update_notification
  
  belongs_to :author, :class_name => 'Account'
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :commentators, :class_name => 'Account', :source => :author ,:through => :comments, :uniq => true
  has_one :notification, :as => :notifiable, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  default_scope :order => 'created_at DESC'
  
  alias :account :author  
  
  def notify!
    Notification.notify!(self)
  end
  
  private
  
  def update_notification
    notification.update_attributes :private_content => blog_private
  end
end
