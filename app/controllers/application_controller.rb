# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem  

  helper :all
  helper_method :'friend?', :'current_account_content?'
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  rescue_from Twitter::TwitterError, :with => :twitter_unauthorized
  rescue_from Timeout::Error, :with => :timeout_error
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error
  rescue_from Exception, :with => :manage_error

  protected

    def current_account_content?(object)
      object.account == current_account
    end
    
    def account_from_path
      @account = Account.scoped_by_login(params[:account_login]).first
    end

    def friend?(account, friend)
      account.friendship(friend)
    end  
  
  private
  
    def twitter_unauthorized(exception)
      log_like_rails(exception)
      flash[:error] = 'A Twitter error has ocurred! ' + exception.message
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
    
    def timeout_error(exception)
      log_like_rails(exception)
      flash[:error] = 'You never got a response!'
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
    
    def not_found_error(exception)
      log_like_rails(exception)
      flash[:error] = 'What you seek couldnt be found!'
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
    
    def manage_error(exception)
      log_like_rails(exception)
      flash[:error] = 'Something went wrong!'
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
    
    def log_like_rails(exception)
      logger.error(
        "\n\n#{exception.class} (#{exception.message}):\n    " + 
        clean_backtrace(exception).join("\n    ") + 
        "\n\n"
      )
    end
    
    def clean_backtrace(exception)
      if backtrace = exception.backtrace
        if defined?(RAILS_ROOT)
          backtrace.map { |line| line.sub RAILS_ROOT, '' }
        else
          backtrace
        end
      end
    end

  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  #não sei pra que serve!
  #session :session_key => '_authentication_session_id'
end
