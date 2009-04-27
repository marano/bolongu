class Gallery < ActiveRecord::Base

  belongs_to :account
  has_many :gallery_photos, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  def cover
    gallery_photos.first(:conditions => { :cover => true })
  end
end
