require 'spec_helper'

describe 'Static Pages' do
	subject { page }

	describe	'Home page' do
		before { visit root_path}

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

	describe 'Navigation' do
		before { visit root_path }
		
		context "should have standard links" do
			it { should have_link("Help",         href: help_path   ) }
			it { should have_link("About",        href: about_path  ) }
			it { should have_link("Contact",      href: contact_path) }
			it { should have_link("Sign in") }
		end

		context "links should go to right pages" do

			it "should go to Hlep page" do
				click_link 'Help'
				page.should have_selector('title', text: 'Help')
			end

			it "should go to About page" do
				click_link 'About'
				page.should have_selector('title', text: 'About')
			end

			it "should go to Contact page" do
				click_link 'Contact'
				page.should have_selector('title', text: 'Contact')
			end
		end
	end
end