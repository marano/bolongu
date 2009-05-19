module StyleHelper
  
  def current_style
    if @account
      stylesheet_link_tag "/style/#{@account.id}/colors"
    elsif logged_in?
      stylesheet_link_tag "/style/#{current_account.id}/colors"
    else
      stylesheet_link_tag "/style/colors"
    end
  end
  
end
