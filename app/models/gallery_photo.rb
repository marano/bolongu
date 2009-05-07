class GalleryPhoto < ActiveRecord::Base

  include Commentable

  acts_as_list

  belongs_to :gallery
  belongs_to :publisher, :class_name => 'Account'
  
  default_scope :order => 'position'
  
  has_attached_file :photo, :styles => { :big => ["800x600>", :jpg], :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg], :micro => ["80x60>", :jpg] }
  
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  def url(*args)
    photo.url(*args)
  end
  
  def swfupload_photo=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.photo = data
  end
  
  alias :account :publisher
  
end
