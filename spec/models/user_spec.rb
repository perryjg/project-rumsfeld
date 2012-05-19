# == Schema Information
#
# Table name: users
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  email        :string(255)
#  phone        :string(255)
#  title        :string(255)
#  organization :string(255)
#  address      :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe User do
	before { @user = FactoryGirl.build(:user) }

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
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:requests) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
			addresses.each do |invalid_email|
				@user.email = invalid_email
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.com USER@f.b.org example.user@foo.cn]
			addresses.each do |valid_email|
				@user.email = valid_email
				@user.should be_valid
			end
		end
	end

	describe "when email is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password is too short" do
		before { @user.password = @user.password_confirmation = "foo" }
		it { should_not be_valid }
	end

	describe "when password does not match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "request associations" do
    before { @user.save }
    let!(:older_request) do
      FactoryGirl.create(:request, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_request) do
      FactoryGirl.create(:request, user: @user, created_at: 1.hour.ago)
    end
    
    it " should have the right requests in the right order" do
      @user.requests.should == [newer_request, older_request]
    end
    
    it "should destroy associated requests" do
      requests = @user.requests
      @user.destroy
      requests.each do | request|
        expect do
          Request.find(request.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
