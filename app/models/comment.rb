class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => 'Account'

  default_scope :order => 'created_at DESC'

  alias :account :author

  def send_notification(url)
    AccountMailer.deliver_comment_notification(commentable.account, self, url)
  end
  
  def self_comment?
    author == commentable.account
  end
  
end
