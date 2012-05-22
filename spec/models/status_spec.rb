# == Schema Information
#
# Table name: statuses
#
#  id              :integer         not null, primary key
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  request_id      :integer
#  status_event_id :integer
#

require 'spec_helper'

describe Status do
	let!(:request)      { FactoryGirl.create(:request) }
	let!(:status_event) { FactoryGirl.create(:status_event) }
	let(:status)        { FactoryGirl.build(:status, request: request) }

	subject { status }

	it { should respond_to :status }
	it { should respond_to(:status_event) }
	it { should respond_to :request }
	its(:request) { should == request }
	it { should be_valid }

	it "should return statuses in the right order" do
		old_status = FactoryGirl.create(:status, request: request, created_at: 1.day.ago)
		new_status = FactoryGirl.create(:status, request: request)

		request.statuses.first.should == new_status
	end

	describe "accessible attruibutes" do
		it "should not allow access to rquest_id" do
			expect do
				Status.new(request_id: request.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "when request_id is missing" do
		before { status.request_id = nil }
		it { should_not be_valid }
	end
end
