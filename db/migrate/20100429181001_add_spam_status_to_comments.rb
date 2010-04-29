class AddSpamStatusToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :spam_status, :string
  end

  def self.down
    remove_column :comments, :spam_status
  end
end
