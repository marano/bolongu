module Taggable

  def self.included(base)
    base.class_eval do
      acts_as_taggable
    end
  end

end
