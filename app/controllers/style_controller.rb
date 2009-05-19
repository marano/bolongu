class StyleController < ApplicationController

  def colors
    default
    
    respond_to do |format|
      format.css { render }
    end
  end
  
  private
  
  def default
    @text = '#333'
    @link = '#666'
    @active = '#ff3300'
    @bg = '#4c8542'    
    @content_bg = '#FFF'
    
#    @base = '#333'
#    @bg = '#4c8542'
#    @link = '#666'
#    @link_hover = '#ff3300'
#    @button_hover = '#ff3300'
#    @content_bg = '#FFF'
#    @button_base = '#FFF'
#    @menu_hover_bg = '#ff3300'
#    @menu_link = '#FFF'
#    @menu_link_hover = '#FFF'
#    @current_menu_bg = '#FFF'
#    @current_menu_link = '#000'
  end
end
