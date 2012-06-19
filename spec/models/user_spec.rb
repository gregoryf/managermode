require 'spec_helper'

describe User do
  
  before do
    @user = Factory(:user)
    @inactive_user = Factory(:user, active: false)
  end
  
  it "finds active users" do
    User.active_users.should include(@user)
    User.active_users.should_not include(@inactive_user)
  end

end
