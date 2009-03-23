class Comment < ActiveRecord::Base

  belongs_to :account
  belongs_to :post
  belongs_to :thing
  
  default_scope :order => 'created_at DESC'

end
