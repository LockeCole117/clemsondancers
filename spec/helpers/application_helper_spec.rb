require "spec_helper"

describe ApplicationHelper do
  describe "markdown renderer" do
    it "should render basic markdown" do
      helper.markdown("#Hello").should == "<h1>Hello</h1>\n"
    end

    it "should render basic markdown" do
      helper.markdown("#Hello").should == "<h1>Hello</h1>\n"
    end

    it "should render image tags" do
      helper.markdown("![test](hello)").should == "<p><img src=\"hello\" alt=\"test\"></p>\n"
    end

    it "should render HTML included in the markdown" do
      helper.markdown("#Hello\n<h3>Test</h3>").should == "<h1>Hello</h1>\n\n<h3>Test</h3>\n"
    end
  end
end