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
	before { @rtype = RequestType.new( name: 'template1', template: 'blah blah blah') }

	subject { @rtype }

	it { should respond_to(:name) }
	it { should respond_to(:template) }
end
