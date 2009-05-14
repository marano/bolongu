class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => 'Account'

  default_scope :order => 'created_at DESC'
  
  validates_presence_of :body

  alias :account :author

  def send_notification(url)
    unless self_comment?
      AccountMailer.deliver_comment_notification(commentable.account, self, url)
    end
  end
  
  def self_comment?
    author == commentable.account
  end
  
end
