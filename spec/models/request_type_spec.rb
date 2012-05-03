require 'spec_helper'

describe RequestType do
	before { @rtype = RequestType.new( name: 'template1', template: 'blah blah blah') }

	subject { @rtype }

	it { should respond_to(:name) }
	it { should respond_to(:template) }
end
