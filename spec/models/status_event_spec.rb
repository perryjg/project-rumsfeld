# == Schema Information
#
# Table name: status_events
#
#  id          :integer         not null, primary key
#  status_name :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe StatusEvent do
	let(:status_event) { FactoryGirl.build(:status_event) }

	subject { status_event }

	it { should respond_to(:status_name) }
	it { should respond_to(:statuses) }
	it { should be_valid }

	describe "should not be valid with blank status_name" do
		before { status_event.status_name = " " }
		it { should_not be_valid }
	end

	describe "uniqueness validation" do
		before do
			status_event.save
		end

   it "should not be valid with duplicate status_name" do
		  duplicate_status = FactoryGirl.build(:status_event, status_name: status_event.status_name)
    	duplicate_status.should_not be_valid
    end

		after { StatusEvent.delete_all }
	end
end
