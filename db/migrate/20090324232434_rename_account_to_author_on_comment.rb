class RenameAccountToAuthorOnComment < ActiveRecord::Migration
  def self.up
    rename_column :comments, :account_id, :author_id
  end

  def self.down
    rename_column :comments, :author_id, :account_id
  end
end
