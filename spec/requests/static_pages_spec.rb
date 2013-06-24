require 'spec_helper'

describe "Static pages" do

  let (:base_title) {"yosup |"}
  subject{page}

  shared_examples_for "all static pages" do
    it {should have_selector('h1', text: heading)}
    it {should have_selector('title', text: page_title)}
  end

  describe "Home page" do
    before {visit root_path}
    let (:heading) {'Saitama Kiwi homepage'}
    let (:page_title) {'yosup'}

    it_should_behave_like "all static pages"
    #it  {should have_selector('h1', text: 'Saitama Kiwi homepage')}
    #it  {should have_selector('title', text: "yosup")}
    it  {should_not have_selector('title', text: '| Home')}
  
    describe "for signed-in users" do
      let(:user){FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "test test")
        FactoryGirl.create(:micropost, user: user, content: "yosup")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      # cannot get this to properly destroy posts, 2 microposts created in before block cause 1 micropost test to fail
      # it "should pluralize post numbers" do
      #   FactoryGirl.create(:micropost, user: user, content: "Food")
      #   page.should have_content("1 micropost")
      #   2.times {FactoryGirl.create(:micropost, user: user, content: "Food")}
      #   page.should have_content("2 microposts")
      # end
    end
  end

  describe "Help page" do
  	before {visit help_path}
    let (:heading) {'help'}
    let (:page_title) {'#{base_title} Help'}

    #it  {should have_selector('h1', text: 'help')}
    #it  {should have_selector('title', text: "#{base_title} Help")}
  end

  describe "about page" do
    before {visit about_path}  	
    let (:heading) {'about us'}
    let (:page_title) {'#{base_title} About'}

    #it  {should have_selector('h1', text: 'about us')}
    #it  {should have_selector('title', text: "#{base_title} About")}
  end

  describe "contact page" do
    before {visit contact_path}   
    let (:heading) {'contact us'}
    let (:page_title) {'#{base_title} Contact'}

    #it  {should have_selector('h1', text: 'contact us')}
    #it  {should have_selector('title', text: "#{base_title} Contact")}
  end

  it "layout links should go to right place" do
    visit root_path
    click_link "About"
    page.should have_selector('title', text: "#{base_title} About")
    click_link "Help"
    page.should have_selector('title', text: "#{base_title} Help")
    click_link "Contact"
    page.should have_selector('title', text: "#{base_title} Contact")
    click_link "Home"
    page.should have_selector('title', text: "yosup")
    click_link "sign up now"
    page.should have_selector('title', text: "#{base_title} Sign Up")
    click_link "sample app"
    page.should have_selector('title', text: "yosup")
  end
end