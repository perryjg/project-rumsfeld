require 'spec_helper'

describe 'Status pages' do
  let!(:status_pending) { FactoryGirl.create(:status_event) }
  let!(:status_sent)    { FactoryGirl.create(:status_event, status_name: 'sent') }
  
  let!(:user)           { FactoryGirl.create(:user) }
  let!(:request)        { FactoryGirl.create(:request, user: user) }
  
  subject { page }
  
  describe "new page" do
    before do
      sign_in user
      visit new_request_status_path(request)
      select 'sent', from: 'Status'
    end
    
    it "should create a new status" do
      expect { click_button 'Update status' }.to change(Status, :count).by(1)
    end
  end
end