require 'spec_helper'

describe Request do
	before { @request = FactoryGirl.build(:request) }
	subject { @request }

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

	it { should be_valid }

	describe "when user id is not present" do
		before { @request.user_id = "" }
		it { should_not be_valid }
	end

	describe "when recipient name is not present" do
		before { @request.recipient_name = "" }
		it { should_not be_valid }
	end

	describe "when recipient address is not present" do
		before { @request.recipient_addr = "" }
		it { should_not be_valid }
	end

	describe "when recipient city is not present" do
		before { @request.recipient_city = "" }
		it { should_not be_valid }
	end

	describe "when recipient state is not present" do
		before { @request.recipient_state = "" }
		it { should_not be_valid }
	end

	describe "when recipient zip is not present" do
		before { @request.recipient_zip = "" }
		it { should_not be_valid }
	end

	describe "when state is too long" do
		before { @request.recipient_state = 'Georgia' }
		it { should_not be_valid }
	end

	describe "when state is too short" do
		before { @request.recipient_state = 'G' }
		it { should_not be_valid }
	end
end
