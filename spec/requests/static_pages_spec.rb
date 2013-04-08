require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "Sample App")
    end

    it "should have the right title" do
  		visit '/static_pages/home'
  		page.should have_selector('title', :text => "yosup | Home")
  	end
  end

  describe "Help page" do
  	it "should have the content 'help'" do
  		visit '/static_pages/help'
  		page.should have_selector('h1', :text => "help")
  	end

  	it "should have the right title" do
  		visit '/static_pages/help'
  		page.should have_selector('title', :text => "yosup | Help")
  	end
  end

  describe "about page" do
  	it "should have the content 'about'" do
  		visit '/static_pages/about'
  		page.should have_selector('h1', :text => "about us")
  	end
  	it "should have the right title" do
  		visit '/static_pages/about'
  		page.should have_selector('title', :text => "yosup | About")
  	end
  end
end