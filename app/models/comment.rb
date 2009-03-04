class Comment < ActiveRecord::Base

  belongs_to :account
  belongs_to :post

end
