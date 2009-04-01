class Scrap < ActiveRecord::Base

  belongs_to :author, :class_name => 'Account'
  belongs_to :recipient, :class_name => 'Account'
  
  default_scope :order => 'created_at DESC'
  
  alias :account :author
  
  def send_notification(url)
    AccountMailer.deliver_scrap_notification(recipient, self, url)
  end
  
end
