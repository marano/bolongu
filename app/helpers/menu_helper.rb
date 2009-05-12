module MenuHelper

  def menu_item(title, links, style)
    show('layouts/menu_item', title, links, style) do
      yield if block_given?
    end
  end
  
  def menu_item_home(title, links, style)
    show('layouts/menu_item_home', title, links, style) do
      yield if block_given?
    end
  end
  
  def show(layout, title, links, style)
    first_link = links.class == Array ? links.first : links
    render :layout => layout, :locals => { :title => title, :link => first_link, :link_style => style, :div_style => current_menu_item(links) } do
      yield if block_given?
    end
  end
  
  private
  
  def current_menu_item(links)
    if links.class == Array
      is = false
      links.each { |link| is = true if current_page?(link) }
    else
      is = true if current_page?(links)
    end    
    return 'current_menu_item' if is
  end

end
