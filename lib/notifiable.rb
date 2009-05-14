module Notifiable

  def self.included(base)
    base.class_eval do    
      after_create :notify!
      after_save :update_notification
      has_one :notification, :as => :notifiable, :dependent => :destroy
      
      attr_accessor :should_notify
      
      include Taggable
      
      #make shure theres a boolean field called blog_private
    end
  end

  def notify!
    unless should_notify == false
      Notification.notify!(self)
    end
  end
  
  def update_notification
    unless notification.nil?
      notification.private_content = blog_private
      notification.tag_list = tag_list
      notification.save
    end
  end

end
