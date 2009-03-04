ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 465,
	:domain => "www.gmail.com",
	:authentication => :login,
	:user_name => "thiagomarano@gmail.com",
	:password => "salamaleicozen"
}
