require 'spec_helper'

describe "Request pages" do
  let!(:user)         { FactoryGirl.create(:user) }
  let!(:status_event) { FactoryGirl.create(:status_event) }
  let!(:request)      { FactoryGirl.create(:request, user: user) }
  before { sign_in user }
  
  subject { page }
  
  describe "index page" do
    let!(:other_user)   { FactoryGirl.create(:user) }
    let!(:other_user_request) { FactoryGirl.create(:request, user: other_user) }
    before { visit requests_path }
    
    it { should have_selector('title', text: "Requests") }
    it { should have_selector('h1', text: "Requests") }
    
    context "should list all users' requests" do
      it { should have_content(request.user.name) }
      it { should have_content(other_user_request.user.name) }
    end

    context "should list requests' current status" do
      it { should have_content(request.current_status.status) }
    end
  end
  
  describe "new page" do
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
     
     context "with valid information" do
       it "should create a new request" do
         expect { click_button "Create new request" }.to change(Request, :count).by(1)
       end
     end
     
     context "with invalid information" do
       before do
         fill_in "Recipient name", with: " "
         click_button "Create new request"
       end
       
       it { should have_selector('title', text: "New request") }
       it { should have_xpath('//div[@class="field_with_errors"]/label[@for="request_recipient_name"]') }
     end
  end
    
  describe "show page" do
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

    context "when request text uses markup formatting" do
      let!(:request_with_markup) { FactoryGirl.create(:request, request_text: "h3. Documents") }
      before { visit request_path(request_with_markup) }

      it { should have_selector('h3', text: "Documents") }
#      it { should have_content('Documents') }
    end

    context "when letter template includes a formatted date" do
      let!(:template_with_date) { FactoryGirl.create(:request_type, template: "DateE {{request.created_at | formal_date }}")}
      let!(:request_with_date) do
        FactoryGirl.create(:request, request_type: template_with_date)
      end
      before { visit request_path(request_with_date) }

      it "should properly display formatted date" do
        page.should have_content(request_with_date.created_at.strftime("%a, %B %d, %Y"))
      end
    end
  end
  
  describe "edit page" do
    let(:new_name) { "New Name" }
    let(:new_request_text) { "Give me my records" }
    before { visit edit_request_path(request) }
    
    it { should have_selector('title', text: "Editing request") }
    
    context "with valid information" do
      before do
        fill_in "Recipient name", with: new_name
        fill_in "Request text",   with: new_request_text
        click_button "Save changes"
      end

      it { should have_selector('title', text: "Request") }
      it { should have_selector('div.alert.alert-notice', text: "Request was successfully updated") }
      specify { request.reload.recipient_name.should == new_name }
      specify { request.reload.request_text.should == new_request_text }
    end
    
    context "with invalid information" do
      before do
        fill_in "Recipient name", with: " "
        click_button "Save changes"
      end
    
      it { should have_selector('title', text: "Editing request") }
      it { should have_xpath('//div[@class="field_with_errors"]/label[@for="request_recipient_name"]') }
    end
  end
  
  describe "edit letter page" do
    let(:new_letter) { "Dear Mindless Bureaucrat, give me your records"}
    before do
      visit request_editletter_path(request)
      fill_in "Letter", with: new_letter
    end
    
    it { should have_selector('title', text: "Editing letter") }
    
    context "when click Save changes" do
      before { click_button "Save changes" }
      specify { request.reload.letter.should == new_letter }
    end
  end
end
