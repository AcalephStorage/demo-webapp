ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'minitest/reporters'
require File.expand_path '../../app.rb', __FILE__

include Rack::Test::Methods
Minitest::Reporters.use!

def app
  DemoMan
end
