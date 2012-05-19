require 'spec_helper'

describe 'Authentication' do
  subject { page }
  
  describe 'signin page' do
    before { visit signin_path }
    
    it { should have_selector('h1',    test: 'Sign in') }
    it { should have_selector('title', test: 'Sign in') }
  end
  
  describe 'signin' do
    before { visit signin_path }
    
    describe 'with invalid information' do
      before { click_button 'Sign in' }
      
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-alert', text: 'invalid') }
    end
    
    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Home',        href: user_path(user)) }
      it { should have_link('Requests',    href: requests_path) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign_in', href: signin_path) }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      context "in Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should_not have_selector('title', text: "Edit user") }
          it { should have_content("Please sign in") }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before do
        visit signin_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      describe "right user signed in" do
        it { should have_selector('title', text: user.name) }
      end

      describe "visiting wrong users's User#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title', text: "Home") }
        it { should have_content("Not Authorized") }
      end

      describe "submitting PUT request to wrong user's User#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end
end