# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#logging
ActiveRecord::Base.logger.level = Logger::DEBUG