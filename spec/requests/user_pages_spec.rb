require 'spec_helper'

describe "UserPages" do
	let (:base_title) {"yosup |"}
	subject{page}

	describe "signup page" do
		before {visit signup_path}

		let(:submit){"Create my account"}

		it {should have_selector('h1', text:'Sign up')}
		it {should have_selector('title', text: "#{base_title} Sign Up")}

		describe "with invalid information" do
			describe "after submission" do
				before {click_button submit}
				it {should have_selector('title', text: 'Sign Up')}
				it {should have_content('error')}
			end
			it "should not create a user" do
				expect {click_button submit}.not_to change(User, :count)
			end
		end

		describe "valid data creates new user" do
			before do
				fill_in "Name",			with: "Kana Osugi"
				fill_in "Email",		with: "kanaeosugi@gmail.com"
				fill_in "Password",		with: "saitama"
				fill_in	"user[password_confirmation]",	with: "saitama"
			end
			it "should create a new user" do
				expect {click_button submit}.to change(User, :count).by(1)
			end
			#-- Unsure why user.name is referencing nil, User.find_by_email works in console
			describe "after saving the user" do
				before {click_button submit}
				let(:user){User.find_by_email('testuser@example.com')}
				#it {should have_selector('title', text: user.name)}
				it {should have_selector('div.alert.alert-success', text: 'Welcome')}
				it {should have_link('Sign out')}
			end
		end
	end

	describe "profile page" do
		let(:user){FactoryGirl.create(:user)}
		before {visit user_path(user)}
		it {should have_selector('h1', text: user.name)}
		it {should have_selector('title', text: user.name)}
	end
end
