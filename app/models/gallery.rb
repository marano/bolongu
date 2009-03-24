class Gallery < ActiveRecord::Base

  belongs_to :account
  has_many :gallery_photos, :dependent => :destroy
  
  def cover
    gallery_photos.first(:conditions => { :cover => true })
  end
end
