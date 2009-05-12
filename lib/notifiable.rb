module Notifiable

  def self.included(base)
    base.class_eval do
      after_create :notify!
      after_save :update_notification
      has_one :notification, :as => :notifiable, :dependent => :destroy
      
      attr_accessor :blog_private
      attr_accessor :should_notify
    end
  end

  def notify!
    unless should_notify == false
      Notification.notify!(self)
    end
  end
  
  def update_notification    
    notification.update_attributes :private_content => blog_private unless notification.nil?
  end

end
