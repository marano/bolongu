class AddTwitterToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :twitter_active, :boolean, :default => false
    add_column :accounts, :twitter_token, :string
    add_column :accounts, :twitter_secret, :string
    
    Account.update_all :twitter_active => false
  end

  def self.down
    remove_column :accounts, :twitter_secret
    remove_column :accounts, :twitter_token
    remove_column :accounts, :twitter_active
  end
end
