# == Schema Information
#
# Table name: requests
#
#  id                     :integer         not null, primary key
#  recipient_name         :string(255)
#  recipient_title        :string(255)
#  recipient_organization :string(255)
#  recipient_addr         :string(255)
#  recipient_city         :string(255)
#  recipient_state        :string(255)
#  recipient_zip          :string(255)
#  request_text           :text
#  user_id                :integer
#  request_type_id        :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  letter                 :text
#

require 'spec_helper'

describe Request do
	let!(:user)     { FactoryGirl.create(:user) }
	let!(:template) { FactoryGirl.create(:request_type) }
	let(:request)   { FactoryGirl.build(:request, user: user, request_type: template) }

	subject { request }

	it { should respond_to(:recipient_name) }
	it { should respond_to(:recipient_title) }
	it { should respond_to(:recipient_organization) }
	it { should respond_to(:recipient_addr) }
	it { should respond_to(:recipient_city) }
	it { should respond_to(:recipient_state) }
	it { should respond_to(:recipient_zip) }
	it { should respond_to(:request_text) }
	it { should respond_to(:user_id) }
	it { should respond_to(:request_type_id) }
	it { should respond_to(:request_type) }
	it { should respond_to(:letter) }
	it { should respond_to(:template) }
	it { should respond_to(:generate_letter) }
	it { should respond_to(:statuses) }
	it { should respond_to(:current_status) }
	it { should respond_to(:sent?) }
	it { should respond_to(:response_received?) }

	it { should be_valid }

	describe "when recipient name is not present" do
		before { request.recipient_name = "" }
		it { should_not be_valid }
	end

	describe "when recipient address is not present" do
		before { request.recipient_addr = "" }
		it { should_not be_valid }
	end

	describe "when recipient city is not present" do
		before { request.recipient_city = "" }
		it { should_not be_valid }
	end

	describe "when recipient state is not present" do
		before { request.recipient_state = "" }
		it { should_not be_valid }
	end

	describe "when recipient zip is not present" do
		before { request.recipient_zip = "" }
		it { should_not be_valid }
	end

	describe "when state is too long" do
		before { request.recipient_state = 'Georgia' }
		it { should_not be_valid }
	end

	describe "when state is too short" do
		before { request.recipient_state = 'G' }
		it { should_not be_valid }
	end

 	describe "letter" do
  		context "before save" do
  			it "should be nill" do
	  			request.letter.should == nil
	  		end
  		end

  		context "after save" do
  			it "should be generated with template variables" do
	      	request.save
	      	saved_request = Request.find(request.id)
	      	saved_request.letter.should include(request.recipient_name)
	    	end
    	end
  	end

	describe "User association" do
	  it { should respond_to(:user) }
	  its(:user) { should == user }
	  
	  	describe "when user_id is not present" do
	    	before { request.user_id = nil }
	    	it { should_not be_valid }
    	end
	  
		describe "accessible attributes" do
	    	it "should not allow access to user_id" do
	     		expect do
	        		Request.new(FactoryGirl.attributes_for(:request, user_id: user.id))
        		end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      		end
    	end
  	end

	describe "status association" do
  		before { request.save }
  		let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'new status') }
	  	let!(:status)       {FactoryGirl.create(:status, request: request, status_event: status_event) }

		it "should be 'pending' upon save" do
			current_status = request.current_status
			current_status.status.should == "new status"
		end
	end

	describe "current_status" do
		before { request.save }
		let!(:old_status) { FactoryGirl.create(:status, request: request, created_at: 1.day.ago) }
		let!(:new_status) { FactoryGirl.create(:status, request: request) }

		it "should return the most recent status" do
			request.current_status.should == new_status
		end
 	end

	describe "sent?" do
		before { request.save }

		it "should return false before sent" do
			request.sent?.should be_false
		end

		context "after request is sent" do
			let!(:status) { FactoryGirl.create(:status, request: request, status_event_id: 2) }
			let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'sent', id: 2) }

			it "should return false" do
				request.sent?.should be_true
			end
		end
	end

	describe "request_received?" do
		before { request.save }

		it "should return false before response received" do
			request.response_received?.should be_false
		end

		context "after request is sent" do
			let!(:status) { FactoryGirl.create(:status, request: request, status_event_id: 2) }
			let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'sent', id: 2) }

			it "should return false" do
				request.sent?.should be_true
			end
		end
	end
	
	describe "is in violation" do
		let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'sent') }
		before do
			request.save
			request.statuses.new( FactoryGirl.attributes_for(:status, status_event_id: status_event.id) )
		end
		 
		it { should respond_to(:is_in_violation?) }
		 
		it "should not be in violation if sent less than 3 business days ago" do
		   request.is_in_violation?.should be_false
		end

		it "should not be in violation when sent 3 business days ago" do
			request.current_status.created_at = 3.business_days.ago
			request.is_in_violation?.should be_false
		end

		it "should be in violation when  sent more than 3 business days ago" do
			request.current_status.created_at = 4.business_days.ago
			request.is_in_violation?.should be_true
		end
	end

	describe "response is due" do
		let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'sent') }
		before do
			request.save
			request.statuses.new( FactoryGirl.attributes_for(:status, status_event_id: status_event.id) )
		end

		it { should respond_to(:response_due?) }

		context "if sent date is less than 3 days ago" do
			it "should be false" do
				request.response_due?.should be_false
			end
		end

		context "if sent date is 3 days ago" do
			it "should be true" do
				request.current_status.created_at = 3.business_days.ago
				request.response_due?.should be_true
			end
		end

		context "if sent date is more than 3 days ago" do
			it "should be false" do
				request.current_status.created_at = 4.business_days.ago
				request.response_due?.should be_false
			end
		end
	end

	describe "Request class methods" do
		let!(:status_event1) { FactoryGirl.create(:status_event) }
		let!(:status_event2) { FactoryGirl.create(:status_event, status_name: 'sent') }
		before do
			request.save
			@request2 = FactoryGirl.create(:request)
			FactoryGirl.create(:status, request: request, status_event_id: 1)
			FactoryGirl.create(:status, request: @request2, status_event_id: 2)
		end

		describe ".unsent" do
			it "should return pending requests" do
				unsent = Request.unsent
				unsent.each do |r|
					r.current_status.status.should == 'pending'
				end
			end 
		end

		describe ".sent" do
			it "should return sent requests" do
				sent = Request.sent
				sent.each do |r|
					r.current_status.status.should == 'sent'
				end
			end 
		end

		describe ".responses_due" do
			it "should return requests with responses do today" do
				@request2.current_status.created_at = 3.days.ago
				due = Request.responses_due
				due.each do |r|
					r.response_due?.should be_true
				end
			end 
		end

		describe ".responses_late" do
			it "should return requests with past-due responses" do
				@request2.current_status.created_at = 4.days.ago
				late = Request.responses_late
				late.each do |r|
					r.response_late?.should be_true
				end
			end 
		end
	end
end
