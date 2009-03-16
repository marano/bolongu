class AccountMailer < ActionMailer::Base
  def signup_notification(account)
    setup_email(account)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://#{SITE_URL}/activate/#{account.activation_code}"
  
  end
  
  def activation(account)
    setup_email(account)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  protected
    def setup_email(account)
      @recipients  = "#{account.email}"
      @from        = "Bolongu! <#{MAILER_ADRESS}>"
      @subject     = "Bolongu! "
      @sent_on     = Time.now
      @content_type = "text/html"
      @body[:account] = account
      @body[:logo] = "http://#{SITE_URL}/images/logo.jpg"
    end
end
