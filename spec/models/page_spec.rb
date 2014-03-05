require 'spec_helper'

describe Page do
  describe "validations" do
    before do
      @page = Page.new(:title => "Hello", :content => "How you doin'?")
      @page.should be_valid
    end


    it "should require a title" do
      @page.title = nil
      @page.should_not be_valid
    end

    it "should require content" do
      @page.content = nil
      @page.should_not be_valid
    end

    it "should not allow a blank title" do
      @page.title = ""
      @page.should_not be_valid
    end

    it "should not allow blank content" do
      @page.content = ""
      @page.should_not be_valid
    end

    it "should not allow duplicate titles" do
      @page.save!

      duplicate_page = Page.new(:title => @page.title, :content => "duplicate!")
      duplicate_page.should_not be_valid
    end
  end

  describe "methods" do
    before do
      @page = Page.create!(:title => "About Us", :content => "How you doin'?")
    end

    it "should return the title lowercased and replacing spaces with underscores" do
      @page.url.should == "about_us"
    end
  end
end
