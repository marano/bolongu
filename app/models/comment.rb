class Comment < ActiveRecord::Base

  belongs_to :account
  belongs_to :post
  belongs_to :thing
  
  default_scope :order => 'created_at DESC'

  def author
    account
  end
  
  def author=(author)
    account = author
  end
end
