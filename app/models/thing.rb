class Thing < ActiveRecord::Base
  
  before_create :notify!
  
  belongs_to :author, :class_name => 'Account'
  has_and_belongs_to_many :accounts
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :commentators, :class_name => 'Account', :source => :author ,:through => :comments, :uniq => true
  has_attached_file :photo, :styles => { :default => ["320x240>", :jpg], :small => ["100x100>", :jpg], :tiny => ["50x50>", :jpg] }
  has_attached_file :attachment
  has_one :notification, :as => :notifiable, :dependent => :destroy

  validates_presence_of :name

  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  validates_attachment_size :attachment, :less_than => 20.megabytes

  default_scope :order => 'created_at DESC'

  alias :account :author
  
  def notify!
    Notification.notify!(self)
  end
  
  def blog_private
    false
  end
end
