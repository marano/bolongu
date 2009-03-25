class Post < ActiveRecord::Base  
  
  belongs_to :account
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_attached_file :photo, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  default_scope :order => 'created_at DESC'
  
  def commentators_size
    total = 0
    counted = []
    for comment in comments do
      if comment.author and !counted.include?(comment.author)
        counted << comment.author
        total += 1
      end
    end
    total
  end
  
end
