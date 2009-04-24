class AccountMailer < ActionMailer::Base

  def comment_notification(account, comment, url)
    setup_email(account)
    @subject += 'comment notification'

    @body[:comment] = comment
    @body[:url] = url
  end

  def scrap_notification(account, scrap, url)
    setup_email(account)
    @subject += 'scrap notification'

    @body[:scrap] = scrap
    @body[:url] = url
  end

  def signup_notification(account)
    setup_email(account)
    @subject += 'Please activate your new account'

    @body[:url] = "http://#{SITE_URL}/activate/#{account.activation_code}"
  end

  def activation(account)
    setup_email(account)
    @subject += 'Your account has been activated!'
    @body[:url] = "http://#{SITE_URL}/"
  end
  
  def password(account)
    setup_email(account)
    @body[:password] = account.password
  end

  protected

  def setup_email(account)
    @recipients  = "#{account.email}"
    @from        = "Bolongu! <#{MAILER_ADRESS}>"
    @subject     = ""
    @sent_on     = Time.now
    @content_type = "text/html"
    @body[:account] = account
    @body[:logo] = "http://#{SITE_URL}/images/logo.jpg"
    @body[:logo_tiny] = "http://#{SITE_URL}/images/logo_tiny.jpg"
  end

end
