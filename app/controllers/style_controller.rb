class StyleController < ApplicationController

  def colors
    fetch
    
    respond_to do |format|
      format.css { render }
    end
  end
  
  private
  
  def fetch    
    if params[:account_id]
      source = Account.find(params[:account_id])
      
      @text = "##{source.style_text_color}"
      @link = "##{source.style_link_color}"
      @active = "##{source.style_active_color}"
      @bg = "##{source.style_bg_color}"
      @content_bg = "##{source.style_content_bg_color}"
    else
      @text = "##{DefaultThemeConfig['text_color']}"
      @link = "##{DefaultThemeConfig['link_color']}"
      @active = "##{DefaultThemeConfig['active_color']}"
      @bg = "##{DefaultThemeConfig['bg_color']}"
      @content_bg = "##{DefaultThemeConfig['content_bg_color']}"
    end
    
#    @text = '#333'
#    @link = '#666'
#    @active = '#ff3300'
#    @bg = '#4c8542'    
#    @content_bg = '#FFF'
    
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
