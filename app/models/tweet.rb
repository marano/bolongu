class Tweet < ActiveRecord::Base

  belongs_to :tweetable, :polymorphic => true
  belongs_to :account
end
