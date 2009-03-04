class AddLastLoginToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :last_login, :time
  end

  def self.down
    remove_column :accounts, :last_login
  end
end
