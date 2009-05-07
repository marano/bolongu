class Gallery < ActiveRecord::Base

  include Notifiable

  belongs_to :account
  has_many :gallery_photos, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :commentators, :class_name => 'Account', :source => :author ,:through => :comments, :uniq => true
  
  default_scope :order => 'created_at DESC'
  
  def cover
    gallery_photos.first(:conditions => { :cover => true }) or gallery_photos.first
  end
end
