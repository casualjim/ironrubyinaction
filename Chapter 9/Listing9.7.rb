require 'rubygems' unless defined? Gem
require 'spec'
require 'mocha'

class CookieJar
  def swipe_cookie
    # complex logic here that swipes a cookie
  end
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

describe "Mocking" do
  it "should be caught" do
    cookie_jar = CookieJar.new    
    msg = "Caught with your fingers in the cookie jar"
    
    cookie_jar.expects(:swipe_cookie).returns(msg)
    cookie_jar.swipe_cookie.should == msg
  end
  
  it "should fail" do
    cookie_jar = CookieJar.new
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.expects(:swipe_cookie).returns(msg)
    end
end

