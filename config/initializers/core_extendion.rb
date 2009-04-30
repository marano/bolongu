class String

  def canonical
    mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
  
  def trim
    gsub(/ /,'')
  end
  
  def self.random(len = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
end

class ActiveRecord::Base
  def helpers
    ActionController::Base.helpers
  end
end
