ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'minitest/reporters'
require 'capybara'
require 'capybara/dsl'
require File.expand_path '../../app.rb', __FILE__

include Rack::Test::Methods
Minitest::Reporters.use!

Capybara.app = DemoMan

class MiniTest::Spec
  include Capybara::DSL
end

def app
  DemoMan
end
