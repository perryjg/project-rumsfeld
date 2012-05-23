require 'spec_helper'

describe "Request Type pages" do
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:template) { FactoryGirl.create(:request_type) }
  before { sign_in user }

  subject { page }

  describe "Index page" do
  	before { visit request_types_path }

  	it { should have_selector('title',  text: "Letter templates") }
  	it { should have_selector('h1',     text: "Letter templates") }
  	it { should have_selector('strong', text: template.name) }
  	it { should have_link("New template", href: new_request_type_path) }
  end

  describe "show page" do
  	before { visit request_type_path(template) }
  	it { should have_selector('title',  text: "#{template.name} template") }
  	it { should have_selector('h1',     text: template.name) }
  	it { should have_selector('strong', text: "{{request.recipient_name}}") }
  end

  describe "new page" do
    let(:new_template) { FactoryGirl.attributes_for(:request_type, name: "New template") }
    before do
     visit new_request_type_path
     fill_in "Name", with: new_template[:name]
     fill_in "Template", with: new_template[:template]
    end

    it { should have_selector('title', text: "New template") }
    it { should have_selector('h1',    text: "New template") }

     context "with valid information" do
       it "should create a new request" do
         expect { click_button "Save Template" }.to change(RequestType, :count).by(1)
      end
    end
     
     context "with invalid information" do
       before do
         fill_in "Name", with: " "
         click_button "Save Template"
       end
       
       it { should have_selector('title', text: "New template") }
       it { should have_xpath('//div[@class="field_with_errors"]/label[@for="request_type_name"]') }
     end
  end

  describe "edit page" do
    let(:new_name) { "New name" }
    before { visit edit_request_type_path(template) }

    it { should have_selector('title', text: "Edit templates") }

    context " with valid information" do
      before do
        fill_in "Name", with: new_name
        click_button "Save Template"
      end

      specify { template.reload.name.should == new_name }
    end
  end
end