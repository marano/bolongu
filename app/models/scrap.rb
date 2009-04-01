class Scrap < ActiveRecord::Base

  belongs_to :author, :class_name => 'Account'
  belongs_to :recipient, :class_name => 'Account'
  
  default_scope :order => 'created_at DESC'
  
  alias :account :author
  
  def send_notification(url)
    AccountMailer.deliver_scrap_notification(recipient, self, url)
  end
  
  def new?
    not read or @recently_read
  end
  
  def mark_as_read
    return if read
    
    update_attribute :read, true
    @recently_read = true
  end
  
end
