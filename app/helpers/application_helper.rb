module ApplicationHelper

  include TagsHelper  

  def javascript(script)
    head javascript_include_tag(script)
  end
  
  def stylesheet(sheet)
    head stylesheet_link_tag(sheet)
  end

  def title(title)
    content_for(:title) { title }
  end

  def head(head)
    content_for(:head) { head }
  end
  
end
