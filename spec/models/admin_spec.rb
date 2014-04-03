require 'spec_helper'

describe Admin do
  describe "validations" do
    describe "failure" do
      before(:each) do
        @attr = {:email => "test@test.com", :password => "test1234", :password_confirmation => "test1234"} # A valid hash
      end

      it "should require a email" do
        Admin.new(@attr.merge(:email => "")).should_not be_valid
      end

      it "should require a unique email" do
        other_admin = Admin.create(@attr.merge(:email => "test@test.com"))
        Admin.new(@attr.merge(:email => "test@test.com")).should_not be_valid
      end

      it "should require a password" do
        Admin.new(@attr.merge(:password => "")).should_not be_valid
      end

      it "should require a password_confirmation" do
        Admin.new(@attr.merge(:password_confirmation => "")).should_not be_valid
      end
    end
    describe "success" do
      before(:each) do
        @admin = Admin.create!({:email => "test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      end
      it "should create a new record" do
        @admin.should_not be_new_record
      end
    end
  end
end
