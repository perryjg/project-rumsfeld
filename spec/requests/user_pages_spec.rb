require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1',    text: 'Sign up') }
		it { should have_selector('title', text: 'Sign up') }
	end

	describe "user home page" do
    let!(:user)         { FactoryGirl.create(:user) }
    let!(:status_event) { FactoryGirl.create(:status_event) }
    let!(:request1)     { FactoryGirl.create(:request, user: user) }
    let!(:request2)     { FactoryGirl.create(:request, user: user) }
    
    before { sign_in user }

		it { should have_selector('h1',    text: user.name) }
		it { should have_selector('title', text: user.name) }
		
		describe "requests" do
		  it { should have_content(request1.recipient_organization) }
		  it { should have_content(request2.recipient_organization) }
		  
		  it { should_not have_selector('td', text: request1.user.name) }
		  it { should_not have_selector('td', text: request2.user.name) }
		  
		  it { should have_link('Edit', href: edit_request_path(request1)) }
		  it { should have_link('Edit', href: edit_request_path(request2)) }
	  end
	end
	
  describe "signup" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count).by(1)
      end
      
      describe "after creating the user" do
        before { click_button "Create my account" }
        
        it { should have_selector('title', text: "Example User") }
        it { should have_link('Sign out', href: signout_path) }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
     sign_in user
     visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', test: "Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-notice') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
