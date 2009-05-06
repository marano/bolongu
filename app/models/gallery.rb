class Gallery < ActiveRecord::Base

  before_create :notify!

  belongs_to :account
  has_many :gallery_photos, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_one :notification, :as => :notifiable, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  def cover
    gallery_photos.first(:conditions => { :cover => true }) or gallery_photos.first
  end
  
  def notify!
    Notification.notify!(self)
  end
  
  def blog_private
    false
  end
end
