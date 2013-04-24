require 'spec_helper'

describe "AuthenticationPages" do
	let (:base_title){"yosup |"}
	subject {page}
	describe "signin page" do
		before {visit signin_path}
		let (:submit){"Sign in"}

		it {should have_selector('h1', text: 'Sign in')}
		it {should have_selector('title', text:"#{base_title} Sign in")}

		describe "with invalid signin information" do
			before {click_button "Sign in"}
			it {should have_selector('title', text: 'Sign in')}
			it {should have_selector('div.alert.alert-error', text: 'Invalid')}
			
			describe "after visiting another page" do
				before{click_link "Home"}
				it {should_not have_selector('div.alert.alert-error')}
			end
		end
		
		# describe "with valid signin information" do
		# 	let(:user){FactoryGirl.create(:user)}
		# 	before do
		# 		fill_in "Email",		with: "test@example.com"
		# 		fill_in "Password",		with: "saitama"
		# 		click_button "Sign in"
		# 	end
		# 	it {should have_selector('title', text: user.name)}
		# 	it {should have_link('Profile', href: user_path(user))}
		# 	it {should have_link('Sign out', href: signout_path)}
		# 	it {should_not have_link('Sign in', href: signin_path)}

		# 	describe "followed by signout" do
		# 		before {click_link "Sign out"}
		# 		it {should have_link('Sign in')}
		# 	end
		# end
	end
end