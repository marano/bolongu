class AddCommentsToAccount < ActiveRecord::Migration
  def self.up
    add_column :comments, :account_id, :integer
  end

  def self.down
    remove_column :comments, :account_id
  end
end
