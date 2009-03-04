class Post < ActiveRecord::Base  
  
  belongs_to :account
  has_many :comments, :dependent => :destroy, :order => 'created_at asc'
  has_many :commentator, :through => :comments, :source => :account, :uniq => true
  
  has_attached_file :photo, :styles => { :default => ["640x480>", :jpg], :small => ["320x240>", :jpg], :tiny => ["160x120>", :jpg] }
  
  validates_attachment_content_type :photo, :content_type => [ 'image/jpeg', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :photo, :less_than => 2.megabytes
  
  def self.find_all_by_account(account)
    all(:conditions => { :account_id => account }, :order => 'created_at desc')
  end
end
