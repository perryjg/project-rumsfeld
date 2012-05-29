require 'spec_helper'

describe PrintLettersController do
	let(:request) { FactoryGirl.create(:request) }

  describe "GET #show" do
  	before { get :show, id: request }

  	subject { response }

    it { should be_success }
    it { should render_template :show }

    it "should assign the request to @request" do
    	assigns(:request).should == request
    end
  end

end
