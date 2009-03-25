class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => 'Account'
  
  default_scope :order => 'created_at DESC'
  
  alias :account :author
  
end
