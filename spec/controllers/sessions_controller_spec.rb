require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do
  
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end
  
  describe "POST 'create'" do
    
    describe "invalid signin" do
      
      before(:each) do
        @attr = { :email => "invalid@example.com", :password => "invalid" }
      end
      
      it "should re-render the signin page" do
        post :create, :session => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should have a flash error message" do
        post :create, :session => @attr
        flash[:error].should =~ /invalid/i
      end
    end
    
    describe "valid signin" do
      
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end
      
      it "should sign in the user" do
        post :create, :session => @attr
        # fill in for signed in users
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should redirect user to his show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    it "should sign out an user" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
