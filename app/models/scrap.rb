class Scrap < ActiveRecord::Base

  belongs_to :author, :class_name => 'Account'
  belongs_to :recipient, :class_name => 'Account'
  
  default_scope :order => 'created_at DESC'
  
  alias :account :author
  
end
