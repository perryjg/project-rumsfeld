require 'spec_helper'

describe "Request pages" do
  let!(:user)    { FactoryGirl.create(:user) }
  let!(:request) { FactoryGirl.create(:request, user: user) }
  before do
    visit signin_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
  subject { page }
  
  describe "request index page" do
    let!(:other_user)   { FactoryGirl.create(:user) }
    let!(:other_user_request) { FactoryGirl.create(:request, user: other_user) }
    before { visit requests_path }
    
    it { should have_selector('title', text: "Requests") }
    it { should have_selector('h1', text: "Requests") }
    
    context "should list all users' requests" do
      it { should have_content(request.user.name) }
      it { should have_content(other_user_request.user.name) }
    end
  end
  
  describe "new_request_page" do
    before do
      @new_request = FactoryGirl.attributes_for(:request, user: user)
       visit new_request_path
       fill_in "Recipient name",         with: @new_request[:recipient_name]
       fill_in "Recipient title",        with: @new_request[:recipient_title]
       fill_in "Recipient organization", with: @new_request[:recipient_organization]
       fill_in "Recipient addr",         with: @new_request[:recipient_addr]
       fill_in "Recipient city",         with: @new_request[:recipient_city]
       fill_in "Recipient state",        with: @new_request[:recipient_state]
       fill_in "Recipient zip",          with: @new_request[:recipient_zip]
       fill_in "Request text",           with: @new_request[:request_text]
     end
     
     it { should have_selector('title', text: "New request") }
     it { should have_selector('h1', text: "New request") }
     it "should create a new request" do
       expect { click_button "Create new request" }.to change(Request, :count).by(1)
     end
  end
    
  describe "show request page" do
    before { visit request_path(request) }
    
    it { should have_selector('title', text: "Request") }
    it { should have_link('Edit', href: edit_request_path(request)) }
    
    it "should display user's name" do
      should have_content(request.user.name)
    end
    
    it "should a recipient orgnaization" do
      should have_content(request.recipient_organization)
    end
    
    context "when it is another user's request" do
      let(:another_user)   { FactoryGirl.create(:user) }
      let(:not_my_request) { FactoryGirl.create(:request, user: another_user) }
      before do
        visit request_path(not_my_request)
      end
      
      it { should_not have_link("Edit") }
    end
  end
end
