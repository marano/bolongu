class Tweet < ActiveRecord::Base

  include Notifiable
  include Commentable

  after_create :tweet!
  before_destroy :untweet!

  belongs_to :tweetable, :polymorphic => true
  belongs_to :account
  
  attr_accessor :options
  
  def should_notify
    tweetable.nil?
  end
  
  def blog_private
    false
  end
  
  def options
    @options ||= {}
  end
  
  def tweet!
    update_attributes :twitter_id => account.twitter_client.update(body, options).id
  end
  
  def untweet!
    begin
      account.twitter_client.status_destroy(twitter_id)
    rescue Twitter::NotFound => e
    end
  end
end
