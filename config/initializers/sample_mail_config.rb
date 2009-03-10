ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:domain => "www.site.com",
	:authentication => :plain,
	:user_name => "xxx@gmail.com",
	:password => "xxx"
}
