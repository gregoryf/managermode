require 'spec_helper'

describe "ActivateUserByEmails" do
  it "should activate a registered user by visiting the activate_account URL with a valid token" do
    @user = Factory(:user)
    visit activate_account_path(@user.sign_up_token)
    @user.reload.active.should == true
    page.should have_content('Your account was activated')
  end
end