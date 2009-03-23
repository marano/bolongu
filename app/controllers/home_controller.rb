class HomeController < ApplicationController
  def index
    @posts = Post.all(:limit => 10)
  end
  
  def about
  end
end
