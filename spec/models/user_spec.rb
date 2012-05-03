require 'spec_helper'

describe User do
	before { @user = User.new(name: 'Joe Reporter', email: 'foo@bar.com',
		                       phone: '555-555-5555', title: 'Reporter',
		                       organization: 'The news', address: '123 Main St',
		                       city: 'Atlnata', state: 'GA', zip: '33333') }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:phone) }
	it { should respond_to(:title) }
	it { should respond_to(:organization) }
	it { should respond_to(:address) }
	it { should respond_to(:city) }
	it { should respond_to(:state) }
	it { should respond_to(:zip) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end
end