class Notification < ActiveRecord::Base

  belongs_to :notifiable, :polymorphic => true
  belongs_to :publisher, :class_name => 'Account'
  
  default_scope :order => 'published_at DESC'
  
  def self.notify!(notifiable)
    notifiable.notification = Notification.new(:notifiable => notifiable, :publisher => notifiable.account, :private_content => notifiable.blog_private, :published_at => notifiable.created_at)
  end
  
  def self.recreate_all!  
    Post.all.each { |notifiable| notifiable.notify! }
    Thing.all.each { |notifiable| notifiable.notify! }
    Gallery.all.each { |notifiable| notifiable.notify! }
  end
end
