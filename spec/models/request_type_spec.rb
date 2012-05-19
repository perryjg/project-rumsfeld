# == Schema Information
#
# Table name: request_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  template   :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe RequestType do
	let(:template) { FactoryGirl.build(:request_type) }

	subject { template }

	it { should respond_to(:name) }
	it { should respond_to(:template) }
	it { should respond_to(:requests) }

	it { should be_valid }

	context "with invalid information" do
		it "should be invalid without a template name" do
			template.name = " "
			template.should_not be_valid
		end

		it "should not be valid without template text" do
			template.template = " "
			template.should_not be_valid
		end
	end
end
