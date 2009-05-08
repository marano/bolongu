module FilterMenuHelper

  def filter_menu(account_link, all_link, network_link)
    render :partial => 'accounts/filter_menu', :locals => { :account_link => account_link, :all_link => all_link, :network_link => network_link }
  end

  def filter_menu_item(title, link, style, current)
    render :partial => 'accounts/filter_menu_item', :locals => { :title => title, :link => link, :style => style, :div_style => current_filter_menu_item(current) }
  end
  
  private
  
  def current_filter_menu_item(current)
    'current_filter_menu_item' if current
  end
  
end
