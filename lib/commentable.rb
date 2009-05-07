module Commentable

  def self.included(base)
    base.class_eval do
      after_create :notify!
      has_one :notification, :as => :notifiable, :dependent => :destroy
    end
  end

  def notify!
    Notification.notify!(self)
  end

end
