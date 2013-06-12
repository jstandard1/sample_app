require 'spec_helper'

describe User do
  
  before do 
    @user = User.new(name: "Kana Osugi", email: "kanaeosugi@gmail.com",	
      password: "saitama", password_confirmation: "saitama")
  end
  
  subject {@user}
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:admin)}
  it {should respond_to(:authenticate)}
  it {should be_valid}
  it {should_not be_admin}

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {should be_admin}
  end

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "no name in form" do
  	before {@user.name =""}
  	it {should_not be_valid}
  end
  describe "no email in form" do
  	before {@user.email = ""}
  	it {should_not be_valid}
  end

  describe "name too long" do
  	before {@user.name = "a"*51}
  	it {should_not be_valid}
  end

  describe "INvalid email format" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end
  end

  describe "valid email format" do
  	it "should be valid" do
  		addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			@user.should be_valid
  		end
  	end
  end

  describe "email address non unique" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end
  	it {should_not be_valid}
  end

  describe "mixed case email" do
    let(:mixed_case_email){"TesT@yoSUP.coM"}
    it "should be saved as lower case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end 
  end

  describe "blank password" do
  	before {@user.password = @user.password_confirmation = " "}
  	it {should_not be_valid}
  end

  describe "passwords dont match" do
  	before {@user.password_confirmation="mismatch"}
  	it {should_not be_valid}
  end

  describe "password too short" do
    before {@user.password = @user.password_confirmation = "a"*5}
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
    before {@user.save}
    let(:found_user){User.find_by_email(@user.email)}

    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password){found_user.authenticate("invalid")}
      it {should_not == user_for_invalid_password}
      it {user_for_invalid_password.should be_false}
    end
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token){should_not be_blank}
  end



end
