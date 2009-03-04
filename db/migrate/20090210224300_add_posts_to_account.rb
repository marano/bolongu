class AddPostsToAccount < ActiveRecord::Migration
  def self.up
    add_column :posts, :account_id, :integer
  end

  def self.down
    remove_column :posts, :account_id
  end
end
