class Thing < ActiveRecord::Base
  
  belongs_to :author, :class_name => 'Account'
  has_and_belongs_to_many :accounts
  has_many :comments
  has_attached_file :photo, :styles => { :default => ["150x150>", :jpg], :small => ["100x100>", :jpg], :tiny => ["50x50>", :jpg] }

end
