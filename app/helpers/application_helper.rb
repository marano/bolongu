module ApplicationHelper

  def javascript(script)
    head javascript_include_tag(script)
  end

  def title(title)
    content_for(:title) { title }
  end

  def head(head)
    content_for(:head) { head }
  end
  
end
