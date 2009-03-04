class AccountObserver < ActiveRecord::Observer
  def after_create(account)
    AccountMailer.deliver_signup_notification(account)
  end

  def after_save(account)
  
    AccountMailer.deliver_activation(account) if account.recently_activated?
  
  end
end
