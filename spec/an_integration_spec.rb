require "capybara/rspec"
require "./app"
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)
