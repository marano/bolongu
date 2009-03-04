class Friendship < ActiveRecord::Base
    belongs_to :account
    belongs_to :friend, :class_name => 'Account'
end
