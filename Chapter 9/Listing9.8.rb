require 'rubygems' unless defined? Gem
require 'spec'

class CookieJar
  def swipe_cookie
    # complex logic here that swipes a cookie
  end
end

describe "Mocking with RSpec" do
  it "should be caught" do
    cookie_jar = mock(CookieJar.new)
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.should_receive(:swipe_cookie) { msg  }

    cookie_jar.swipe_cookie.should == msg
  end
  
  it "should fail" do
    cookie_jar = mock(CookieJar.new)
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.should_receive(:swipe_cookie) { msg  }
  end
end

