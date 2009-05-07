module Notifiable

  def self.included(base)
    base.class_eval do
      after_create :notify!
      after_save :update_notification
      has_one :notification, :as => :notifiable, :dependent => :destroy
    end
  end

  def notify!
    Notification.notify!(self)
  end
  
  def update_notification
    notification.update_attributes :private_content => blog_private
  end

end
