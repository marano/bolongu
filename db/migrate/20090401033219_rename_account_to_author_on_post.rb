class RenameAccountToAuthorOnPost < ActiveRecord::Migration
  def self.up
    rename_column :posts, :account_id, :author_id
  end

  def self.down
    rename_column :posts, :author_id, :account_id
  end
end
