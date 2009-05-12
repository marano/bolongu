class Notification < ActiveRecord::Base

  include Taggable

  belongs_to :notifiable, :polymorphic => true
  belongs_to :publisher, :class_name => 'Account'
  
  default_scope :order => 'published_at DESC'
  
  named_scope :from_and_to_account, lambda { |account| { :conditions => "publisher_id = #{account.id} OR (publisher_id IN (#{account.friend_ids_as_string}) AND (private_content = 'false' OR private_content = 'f'))" } }
  
  named_scope :to_account, lambda { |account| { :conditions => "publisher_id IN (#{account.friend_ids_as_string}) AND (private_content = 'false' OR private_content = 'f')" } }
  
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
