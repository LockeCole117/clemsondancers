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

    it "should set the URL automatically" do
      @page.save!
      @page.url.should == "hello"
    end

    it "should allow a custom URL to be set" do
      @page.url = "test"
      @page.save!

      @page.url.should == "test"
    end

    it "should not allow duplicate URLs" do
      @page.save!

      duplicate_page = Page.new(:title => "New", :content => "duplicate!", :url => @page.url)
      duplicate_page.should_not be_valid
    end
  end

  describe "reserve titles and names" do
    describe "superuser" do
      before do
        @reserved_url = "superuser"
        @reserved_title = "Superuser"
        @page = Page.new(:title => "blabla", :content => "hello")
        @page.should be_valid
      end

      it "should not allow lowercase reserved url" do
        @page.url = @reserved_url

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved url" do
        @page.url = @reserved_url.upcase

        @page.should_not be_valid
      end

      it "should not allow reserved title" do
        @page.title = @reserved_title

        @page.should_not be_valid
      end

      it "should not allow lowercase title" do
        @page.title = @reserved_title.downcase

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved title" do
        @page.title = @reserved_title.upcase

        @page.should_not be_valid
      end

    end

    describe "gallery" do
      before do
        @reserved_url = "gallery"
        @reserved_title = "Gallery"
        @page = Page.new(:title => "blabla", :content => "hello")
        @page.should be_valid
      end

      it "should not allow lowercase reserved url" do
        @page.url = @reserved_url

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved url" do
        @page.url = @reserved_url.upcase

        @page.should_not be_valid
      end

      it "should not allow reserved title" do
        @page.title = @reserved_title

        @page.should_not be_valid
      end

      it "should not allow lowercase title" do
        @page.title = @reserved_title.downcase

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved title" do
        @page.title = @reserved_title.upcase

        @page.should_not be_valid
      end
    end

    describe "admin" do
      before do
        @reserved_url = "admin"
        @reserved_title = "Admin"
        @page = Page.new(:title => "blabla", :content => "hello")
        @page.should be_valid
      end

      it "should not allow lowercase reserved url" do
        @page.url = @reserved_url

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved url" do
        @page.url = @reserved_url.upcase

        @page.should_not be_valid
      end

      it "should not allow reserved title" do
        @page.title = @reserved_title

        @page.should_not be_valid
      end

      it "should not allow lowercase title" do
        @page.title = @reserved_title.downcase

        @page.should_not be_valid
      end

      it "should not allow uppercase reserved title" do
        @page.title = @reserved_title.upcase

        @page.should_not be_valid
      end

    end

  end

  describe "methods" do
    before do
      @page = Page.create!(:title => "About Us", :content => "How you doin'?")
    end

    it "should return the title lowercased and replacing spaces with underscores" do
      @page.url.should == "about_us"
    end

    it "should allow the page to be set as the index" do
      @page.index = true
      @page.save!
      @page.index?.should == true
    end

    it "should not freak out if index == true on this page and it is the index" do
      @page.index = true
      @page.save!
      @page.index?.should == true

      @page.title = "About Us"
      @page.save!
      @page.index?.should == true
    end

    it "change the index from one page to another, unsetting the first page as the index" do
      @page.index = true
      @page.save!
      @page.index?.should == true

      new_index = Page.create!(:title => "Home", :content => "Welcome!")
      new_index.index = true
      new_index.save!
      new_index.index?.should == true

      @page.reload.index.should == false
    end

    it "should set the index if there are no pages in the database" do
      Page.destroy_all
      Page.count.should == 0

      @page = Page.create!(:title => "First Page", :content => "First!")
      @page.index?.should == true
    end

    it "should set the index if this is the only page in the database" do
      Page.count.should == 1
      Page.first.should == @page

      @page.index = false
      @page.save!
      @page.index?.should == true
    end

    it "should make it easy to mark a page as the index" do
      @new_page = Page.create!(:title => "First Page", :content => "Test")
      @new_page.mark_as_index
      @new_page.index?.should == true

      @new_page.reload
      @new_page.index?.should == false
    end

    it "should make it easy to mark a page as the index and save it automatically" do
      @new_page = Page.create!(:title => "First Page", :content => "Test")
      @new_page.mark_as_index!
      @new_page.index?.should == true

      @new_page.reload
      @new_page.index?.should == true
    end
  end

  describe "scopes" do
    it "should return the Index page" do
      @page = Page.create!(:title => "Index", :content => "Stuff")
      @page.save!

      Page.index.should == @page
    end
  end
end
