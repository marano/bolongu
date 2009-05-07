module MenuHelper

  def menu_item(title, link, style)
    show('layouts/menu_item', title, link, style) do
      yield if block_given?
    end
  end
  
  def menu_item_home(title, link, style)
    show('layouts/menu_item_home', title, link, style) do
      yield if block_given?
    end
  end
  
  def show(layout, title, link, style)
    render :layout => layout, :locals => { :title => title, :link => link, :link_style => style, :div_style => current_menu_item(link) } do
      yield if block_given?
    end
  end
  
  private
  
  def current_menu_item(link)
    'current_menu_item' if current_page?(link)
  end

end
