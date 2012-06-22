require 'spec_helper'

describe User do
  
  before do
    User.destroy_all
    @user = Factory(:user)
  end
  
  it "does not create user with invalid username" do
    Factory.build(:user, username: nil).should_not be_valid # can't be blank
    Factory.build(:user, username: "!-<>~`%?").should_not be_valid # alpha-numeric only
    Factory.build(:user, username: "waytoolongname1").should_not be_valid # < 14 chars
  end
  
  it "does not create user with invalid password" do
    Factory.build(:user, password: '12345').should_not be_valid
  end
  
  it "creates new user as inactive" do
    @user.active.should_not == true
  end
  
  it "creates sign_up_token after creating new user" do
    @user.sign_up_token.should_not == nil
  end
  
  it "send email to new sign ups with link to activation url" do
    ActionMailer::Base.deliveries.last.to.should == [@user.email]
  end

  it "finds active users" do
    @activated_user = Factory(:user, active: true)
    User.active_users.should include(@activated_user)
    User.active_users.should_not include(@user)
  end
end
