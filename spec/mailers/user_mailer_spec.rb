require "spec_helper"

describe UserMailer do

  describe "welcome message" do
  
    before do
      User.destroy_all
      @user = Factory(:user)
    end
  
    it "renders successfully" do
      lambda { UserMailer.welcome_message(@user) }.should_not raise_error
    end
    
    describe "rendered without error" do
      
      before do
        @mailer = UserMailer.welcome_message(@user)
      end
      
      it "contains a link to unique activation url" do
        @mailer.body.should have_content(activate_account_url(@user.sign_up_token))
      end

    end

  end
  
  describe "forgot_password" do
  end

end
