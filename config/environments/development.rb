Utour::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer QQ config
  # ActionMailer::Base.delivery_method = :smtp  
  # config.action_mailer.perform_deliveries = true  
  # config.action_mailer.raise_delivery_errors = true  
  # config.action_mailer.default :charset => "utf-8"  
  # config.action_mailer.default_url_options = { :host => 'localhost:3000' }  
  # ActionMailer::Base.smtp_settings = {    
  #   :address => "smtp.qq.com",  
  #   :port => 465,  
  #   :domain => "qq.com",   
  #   :user_name => "49491748@qq.com",  
  #   :password => "****",
  #   :ssl => true,
  #   authentication: 'login',
  #   openssl_verify_mode: 'none',
  #   enable_starttls_auto: true
  # }

  # ActionMailer 163 config
  ActionMailer::Base.delivery_method = :smtp  
  config.action_mailer.perform_deliveries = true  
  config.action_mailer.raise_delivery_errors = true  
  config.action_mailer.default :charset => "utf-8"  
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }  
  ActionMailer::Base.smtp_settings = {    
    address: "smtp.163.com",  
    port: 465,  
    domain: "163.com",   
    user_name: "utouradmin@163.com",  
    password: "uxpm6eap",
    ssl: true,
    authentication: 'login',
    openssl_verify_mode: 'none',
    enable_starttls_auto: true
  }

  
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #Paperclip.options[:command_path] = "/usr/local/bin/convert"
  config.action_mailer.asset_host = 'http://0.0.0.0:3000'
end