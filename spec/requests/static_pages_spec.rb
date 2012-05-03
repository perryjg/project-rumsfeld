require 'spec_helper'

describe 'Static Pages' do
	subject { page }
	before { visit root_path}

	describe	'Home page' do
		it { should have_selector('h1', :text => 'Rumsfeld') }
		it { should have_selector( 'title', :text => 'Rumsfeld | Home' ) }
	end

	describe	'Help page' do
		before { visit help_path }

		it { should have_selector('h1', :text => 'Help') }
		it { should have_selector( 'title', :text => 'Rumsfeld | Help' ) }
	end

	describe	'About page' do
		before { visit about_path }

		it { should have_selector('h1', :text => 'About') }
		it { should have_selector( 'title', :text => 'Rumsfeld | About' ) }
	end

	describe	'Contact page' do
		before { visit contact_path }

		it { should have_selector('h1', :text => 'Contact') }
		it { should have_selector( 'title', :text => 'Rumsfeld | Contact' ) }
	end
end