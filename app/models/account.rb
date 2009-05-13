require 'digest/sha1'

class Account < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :posts, :dependent => :destroy, :limit => 10, :order => 'created_at desc', :foreign_key => 'author_id'
  has_many :friendships, :dependent => :destroy, :include => :friend
  has_many :friends, :through => :friendships, :source => :friend, :order => 'last_login DESC'
  has_many :fans, :through => :friendships, :source => :account, :order => 'last_login DESC'
  has_and_belongs_to_many :things
  has_many :galleries, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy, :foreign_key => 'publisher_id'
  has_many :scraps, :foreign_key => 'recipient_id'
  has_many :notifications, :foreign_key => 'publisher_id'
  
  has_attached_file :avatar, :styles => { :default => ["170x200>", :jpg], :small => ["100x100>", :jpg], :tiny => ["50x50>", :jpg], :micro => ["42x32>", :png], :menu => ["60x60>", :jpg] }
  
  validates_attachment_content_type :avatar, :content_type => [ 'image/jpeg', 'image/pjpeg', 'image/x-png', 'image/png', 'image/bmp' , 'image/gif' ]
  validates_attachment_size :avatar, :less_than => 2.megabytes

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => false
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 
  before_create { |account| account.name = account.login.capitalize if account.name.blank? }

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :bio, :password, :password_confirmation, :blog_title, :avatar, :twitter_token, :twitter_secret, :twitter_active

  def twitter_oauth
    @twitter_oauth ||= Twitter::OAuth.new(TwitterConfig['token'], TwitterConfig['secret'])
  end
  
  def twitter_client
    @twitter_client ||= begin
      twitter_oauth.authorize_from_access(twitter_token, twitter_secret)
      Twitter::Base.new(twitter_oauth)
    end
  end

  def generate_random_password!
    self.password_confirmation = self.password = String.random
    save
  end

  def friendship(friend)
    friendships.scoped_by_friend_id(friend.id).first
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  
  def all_notifications
    if friend_ids.empty?
      notifications
    else
      Notification.from_and_to_account(self)
    end
  end
  
  def network_notifications
    unless friend_ids.empty?
      Notification.to_account(self)
    else
      Notification.scoped_by_id(0)
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    ok = u && u.authenticated?(password)
    u.logged_in! if ok
    ok ? u : nil
  end
  
  def logged_in!
    update_attributes last_login => Time.now
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def to_s
    name
  end
  
  def friend_ids_as_string
    _friend_ids = ""
    friend_ids.each do |id|
      _friend_ids << ',' unless _friend_ids.blank?
      _friend_ids << id.to_s
    end
    _friend_ids
  end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end

end
