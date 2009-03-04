class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.references :account
      t.references :friend

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
