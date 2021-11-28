ENV["RACK_ENV"] = 'test'
# Environment variable RACK_ENV set to 'test', communicates to various parts of
# Sinatra and Rack that this file is being used to test code. This info can be
# used in different ways, in the case of Sinatra it tells it that we don't need
# it to run a web server (we don't need to when running tests).

require 'minitest/autorun'
require 'rack/test'
# Require minitest/autorun, requires minitest libraries for testing, allows us
# define our test suite class to inherit from Minitest::Test. Also ensures that
# all of our tests are run automatically (and in a random order?)

# require 'rack/test' gives us access to the Rack::Test module which contains
# helper methods we'll use in our test cases.

require_relative "../app"
# We evaluate the code in ../app so that we can write tests that are run
# against it.

class AppTest < Minitest::Test
  include Rack::Test::Methods
  # Helpful testing helper methods, they require a method called `app` to exist
  # that returns an instance of a Rack application.

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    # Make a get request (could also be post or another HTTP-method)
    assert_equal 200, last_response.status
    # last_response accesses the response 
    # (an instance of the class Rack::MockResponse)
    # This class provides #status, #body, and #[] instance methods to run
    # on it's instances to return the status, body, and specified headers.

    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_equal "Hello, world!", last_response.body
    # We use standard assertions supplied by Minitest to test against the
    # values returned by the MockResponse instance methods.
  end
end