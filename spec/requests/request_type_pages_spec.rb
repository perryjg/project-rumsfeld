require 'spec_helper'

describe "Request Type pages" do
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:template) { FactoryGirl.create(:request_type) }
  before do
    visit signin_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

  end
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
  	it { should have_selector('title', text: "#{template.name} template") }
  	it { should have_selector('h1',    text: template.name) }
  	it { should have_selector('strong', text: "{{recipient_name}}") }
  end
end