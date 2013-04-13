require 'spec_helper'

describe "Static pages" do

  let (:base_title) {"yosup |"}
  subject{page}

  describe "Home page" do
    before {visit root_path}
    it  {should have_selector('h1', text: 'Saitama Kiwi homepage')}
    it  {should have_selector('title', text: "yosup")}
    it  {should_not have_selector('title', text: '| Home')}
  end

  describe "Help page" do
  	before {visit help_path}
    it  {should have_selector('h1', text: 'help')}
    it  {should have_selector('title', text: "#{base_title} Help")}
  end

  describe "about page" do
    before {visit about_path}  	
    it  {should have_selector('h1', text: 'about us')}
    it  {should have_selector('title', text: "#{base_title} About")}
  end

  describe "contact page" do
    before {visit contact_path}   
    it  {should have_selector('h1', text: 'contact us')}
    it  {should have_selector('title', text: "#{base_title} Contact")}
  end
end