class CreateAccountThingAssociation < ActiveRecord::Migration

  def self.up
    create_table :accounts_things, :id => false do |t|
      t.integer :account_id
      t.integer :thing_id
    end
  end

  def self.down
    drop_table :accounts_things
  end
end
