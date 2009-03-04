# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    content_for(:title) { title }
  end
  
  def current_account_content?(object)
    object.account == current_account
  end
  
  def friend?(account, friend)
    account.friends.include?(friend)
  end
end
