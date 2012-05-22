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
  	let!(:status_event) { FactoryGirl.create(:status_event, status_name: 'pending') }
  	before { request.save }

		it "should be 'pending' upon save" do
			current_status = request.current_status
			current_status.status.should == "pending"
		end

		describe "current_status" do
			let!(:old_status) { FactoryGirl.create(:status, request: request, created_at: 1.day.ago) }
			let!(:new_status) { FactoryGirl.create(:status, request: request) }

			it "should return the most recent status" do
				request.current_status.should == new_status
			end
		end
	end
end
