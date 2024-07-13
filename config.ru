# This file is used by Rack-based servers to start the application.

# If using Bundler, require the gems listed in Gemfile
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require_relative 'config/environment'

run Rails.application
