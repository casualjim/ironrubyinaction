require File.dirname(__FILE__) + "/../spec_helper"

shared_examples_for "an event publisher" do
  
  it "should not raise an error when subscribing to an event" do
    lambda { ClrModels::ExposedChangedSubscriber.new(@proxy) }.should_not raise_error
  end
  
  it "should have 1 event subscription" do
    @proxy.isolation_context.events.size.should == 1
  end
  
  it "should raise an event when no block is given" do
    @proxy.when_receiving(:explode)
          .return(nil)
          .raise_event(:on_is_exposed_changed)
    @proxy.explode
    @subscriber.counter.should == 1
  end

  it "should raise an event with the provided parameters" do
    @proxy.when_receiving(:explode)
          .return(nil)
          .raise_event(:on_is_exposed_changed, @sender, @ags)
    @proxy.explode
    @subscriber.sender.should == @sender
    @subscriber.args.should == @ags
  end

  it "should allow overriding the default event handler" do
    cnt, rsen, rar = 0, nil, nil
    handler = lambda { |sen, ar| cnt +=1; rsen = sen; rar=ar   }
    @proxy.when_receiving(:explode)
          .return(nil)
          .raise_event(:on_is_exposed_changed, @sender, @ags, &handler)
    @proxy.explode
    rsen.should == @sender
    rar.should == @ags
    cnt.should == 1
    @subscriber.counter.should == 0
  end

  it "should allow adding a block to the default event handler" do
    cnt = 0
    handler = lambda { |sen, ar| cnt +=1   }
    @proxy.when_receiving(:explode) do |exp|
      exp.return(nil)
      exp.raise_event(:on_is_exposed_changed, @sender, @ags, &handler)
      exp.raise_subscriptions
    end
    @proxy.explode
    cnt.should == 1
    @subscriber.counter.should == 1
  end

  it "should verify if an event was raised" do
    @proxy.when_receiving(:explode)
          .return(nil)
          .raise_event(:on_is_exposed_changed)
    @proxy.explode
    @proxy.should have_raised(:on_is_exposed_changed)
  end

  it "should verify if an event was raised with specific parameters" do
    @proxy.when_receiving(:explode)
          .return(nil)
          .raise_event(:on_is_exposed_changed, @sender, @ags)
    @proxy.explode
    @proxy.should have_raised(:on_is_exposed_changed) { |ev| ev.with(@sender, @ags)}
  end
  
end

describe "CLR event handling" do
  
  before(:each) do
    @sender = { :the => "sender" }
    @ags = System::EventArgs.empty
  end

  describe "for CLR interfaces" do

    before(:each) do
      @proxy = isolate ClrModels::IExplodingWarrior
      @subscriber = ClrModels::ExposedChangedSubscriber.new(@proxy)
    end

    it_should_behave_like "an event publisher"

   end

  describe "for CLR classes" do
  
    before(:each) do
      @proxy = isolate ClrModels::ExposingWarrior
      @subscriber = ClrModels::ExposedChangedSubscriber.new(@proxy)
    end

    it_should_behave_like "an event publisher"
  
  end

end
