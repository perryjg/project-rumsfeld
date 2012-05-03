require 'spec_helper'

describe 'Static Pages' do
	before { visit '/static_pages/home'}

	describe	'Home page' do
		it 'should have content "Rumsfeld"' do
			page.should have_selector('h1', :text => 'Rumsfeld')
		end

		it 'should have the right title' do
			page.should have_selector( 'title', :text => 'Rumsfeld | Home' )
		end
	end

	describe	'Help page' do
		before { visit '/static_pages/help' }

		it 'should have content "Help"' do
			page.should have_selector('h1', :text => 'Help')
		end

		it 'should have the right title' do
			page.should have_selector( 'title', :text => 'Rumsfeld | Help' )
		end
	end

	describe	'About page' do
		before { visit '/static_pages/about' }

		it 'should have content "About"' do
			page.should have_selector('h1', :text => 'About')
		end

		it 'should have the right title' do
			page.should have_selector( 'title', :text => 'Rumsfeld | About' )
		end
	end
end