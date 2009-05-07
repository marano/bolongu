module Commentable

  def self.included(base)
    base.class_eval do
      has_many :comments, :as => :commentable, :dependent => :destroy
      has_many :commentators, :class_name => 'Account', :source => :author ,:through => :comments, :uniq => true
    end
  end

end
