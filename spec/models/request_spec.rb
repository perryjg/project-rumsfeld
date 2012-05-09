require 'spec_helper'

describe Request do
	let(:request) { FactoryGirl.create(:request) }
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

	it { should be_valid }
end
