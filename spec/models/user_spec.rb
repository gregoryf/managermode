require 'spec_helper'

describe User do
  
  before do
    @inactive_user = Factory(:user)
    @user = Factory(:user, active: true)
  end
  
  it "finds active users" do
    User.active_users.should include(@user)
    User.active_users.should_not include(@inactive_user)
  end
  
  it "creates new user as inactive and creates token for activation and
      emails user sign up token" do
    user = Factory(:user)
    user.active.should_not == true
    user.sign_up_token.should_not == nil
    ActionMailer::Base.deliveries.last.to.should == [user.email]
  end
end
