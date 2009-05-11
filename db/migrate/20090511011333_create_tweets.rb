class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :body
      t.references :tweetable, :polymorphic => true
      t.references :account
      t.integer :twitter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
