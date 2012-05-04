# == Schema Information
#
# Table name: letters
#
#  id                  :integer         not null, primary key
#  sender              :string(255)
#  sender_title        :string(255)
#  sender_organization :string(255)
#  sender_email        :string(255)
#  recipient           :string(255)
#  email               :string(255)
#  title               :string(255)
#  organization        :string(255)
#  address             :string(255)
#  city                :string(255)
#  state               :string(255)
#  zip                 :string(255)
#  final_text          :text
#  user_id             :integer
#  request_type_id     :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  request_text        :text
#

require 'spec_helper'

describe Letter do
	before { @letter = Letter.new( sender: 'Joe Reporter', sender_title: 'Reporter',
		                           sender_organization: 'The News',
		                           sender_email: 'foo@bar.com',
		                           recipient: 'John Doe',
		                           email: 'foo@baz.com',
		                           title: 'Public Information Officer',
		                           organization: 'Some Agency',
		                           city: 'Atlanta', state: 'GA', zip: '33333',
		                           request_text: 'Your records are belong to us.') }

	subject { @letter }

	it { should respond_to(:sender) }
	it { should respond_to(:sender_title) }
	it { should respond_to(:sender_organization) }
	it { should respond_to(:sender_email) }
	it { should respond_to(:recipient) }
	it { should respond_to(:email) }
	it { should respond_to(:title) }
	it { should respond_to(:organization) }
	it { should respond_to(:city) }
	it { should respond_to(:state) }
	it { should respond_to(:zip) }	
	it { should respond_to(:request_text) }

	it { should be_valid }
end
