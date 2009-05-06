class Notification < ActiveRecord::Base

  belongs_to :notifiable, :polymorphic => true
  belongs_to :publisher, :class_name => 'Account'
  
  default_scope :order => 'published_at DESC'
  
  before_create :extract_attributes
  
  def self.notify!(notifiable)
    notifiable.notification = Notification.new(:notifiable => notifiable)
  end
  
  def self.recreate_all!  
    Post.all.each { |notifiable| notifiable.notify! }
    Thing.all.each { |notifiable| notifiable.notify! }
    Gallery.all.each { |notifiable| notifiable.notify! }
  end
  
  private
  
  def extract_attributes
    self.publisher = notifiable.account
    self.private_content = notifiable.blog_private
    self.published_at = notifiable.created_at    
  end
end
