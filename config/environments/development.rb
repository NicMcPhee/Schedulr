# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Start up instances of Workling and Starling
# I had to wrap it in the after_initialize call, or trying to run
# things like script/generate threw exceptions that they couldn't
# find MemCache. None of the stuff I read explained _why_ that was
# necessary, but it did appear to work.
# http://www.ruby-forum.com/topic/182018
config.after_initialize do
  Workling::Remote.dispatcher = Workling::Remote::Runners::StarlingRunner.new
end