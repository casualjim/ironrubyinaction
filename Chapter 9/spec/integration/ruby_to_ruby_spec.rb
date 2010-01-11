require File.dirname(__FILE__) + "/../spec_helper"

shared_examples_for "a ruby to ruby interaction" do
  
  it "should work without expectations" do
    result = @dagger.attack @soldier
    result.should be_nil

    @soldier.should have_received(:survive_attack_with, @dagger)
  end

  it "should work for expectations with an argument constraint" do
    @soldier.when_receiving(:survive_attack_with).with(@dagger).return(5)

    @dagger.attack(@soldier).should == 5

    @soldier.should have_received(:survive_attack_with)
  end

  it "should work for expectations with an argument constraint when a wrong argument is passed in" do
    @soldier.when_receiving(:survive_attack_with).with(@dagger).return(5)

    @dagger.attack(Soldier.new).should_not == 5

    @soldier.should_not have_received(:survive_attack_with, @dagger)
  end

  it "should work for expectations with an argument constraint and an assertion argument constraint" do
    soldier = Soldier.new
    @soldier.when_receiving(:survive_attack_with).with(@dagger).return(5)

    @dagger.attack(@soldier).should == 5

    @soldier.should have_received(:survive_attack_with).with(@dagger)
  end

  it "should fail for expectations with an argument constraint and an assertion argument constraint" do
    soldier = Soldier.new
    @soldier.when_receiving(:survive_attack_with).with(@dagger).return(5)

    @dagger.attack(@soldier).should == 5

    @soldier.should_not have_received(:survive_attack_with, Dagger.new)
  end

  it "should work with an expectation for any arguments" do
    @soldier.when_receiving(:survive_attack_with).return(5)

    result = @dagger.attack @soldier
    result.should == 5

    @soldier.should have_received(:survive_attack_with, :any)
  end

  it "should work with an assertion for specific arguments" do
    @soldier.when_receiving(:survive_attack_with) do |method_should|
      method_should.return(5)
    end

    result = @dagger.attack @soldier
    result.should == 5

    @soldier.should have_received(:survive_attack_with).with(@dagger)
  end

  it "should fail for an assertion with wrong arguments" do
    @soldier.when_receiving(:survive_attack_with) do |method_should|
      method_should.return(5)
    end

    result = @dagger.attack @soldier
    result.should == 5

    @soldier.should_not have_received(:survive_attack_with, isolate(Dagger))
  end
  
  it "should execute a callback when an expectation is being invoked and with is not defined in a block" do
    iso = isolate Dagger
    cnt = 0
    iso.when_receiving(:damage).with(:any) do |*args|
       cnt += 1
    end 
    iso.damage       
    cnt.should == 1
  end   
  
  it "should execute a callback when an expectation is being invoked and with is defined in a block" do
    cnt = 0
    iso = Caricature::Isolation.for(Dagger) 
    iso.when_receiving(:damage) do |exp| 
      exp.with(:any) do |*args|
         cnt += 1
      end
    end  
    iso.damage       
    cnt.should == 1
  end

end

describe "Ruby to Ruby interactions" do

  describe "when isolating Ruby classes" do

    before do
      @dagger = Dagger.new
      @soldier = isolate Soldier
    end

    it_should_behave_like 'a ruby to ruby interaction'
  end
  
  describe "when isolating Ruby classes with class members" do
    
    before do
      @dagger = Dagger.new
      @soldier = isolate SoldierWithClassMembers
    end
    
    it_should_behave_like 'a ruby to ruby interaction'    
    
    it "should work for an expctation on a class method without an argument constraint" do
      @soldier.when_class_receives(:class_name).return(5)

      @soldier.class.class_name.should == 5

      @soldier.class.should have_received(:class_name)
    end
        
  end
  
  describe "when isolating Ruby instances" do
    before do
      @dagger = Dagger.new
      @soldier = isolate Soldier.new
    end
    
    it_should_behave_like 'a ruby to ruby interaction'
    
    it "should allow to delegate the method call to the real instance (partial mock)" do
      @soldier.when_receiving(:survive_attack_with).super_after

      result = @dagger.attack @soldier
      result.should == 8

      @soldier.should have_received(:survive_attack_with)
    end
    
    it "should be able to isolate objects with constructor params" do
      sheath = isolate Sheath
      sheath.when_receiving(:insert).raise("Already inserted")
      lambda { sheath.insert(@dagger) }.should raise_error(/^Already inserted$/)
    end 
    
    it "should be able to isolate objects with constructor params" do
      sheath = isolate(Sheath)
      lambda { sheath.insert(@dagger) }.should_not raise_error
    end
    
  end
end

