require 'spec_helper'

describe 'paginating', :type => :request, :driver => :selenium, :js => true do
  it 'works' do
    visit("http://localhost:3000") # goes to welcome page
    page.should have_selector('#welcomepagetitle')
    page.should have_no_selector('#aboutpagetitle')
    click_link 'About'
    page.should have_selector('#aboutpagetitle')
    page.should have_no_selector('#readmepagetitle')
    click_link 'Readme'
    page.should have_selector('#readmepagetitle')
    page.should have_no_selector('#aboutpagetitle')
  end
  it 'still works with nested and multiple paginated sections' do
    visit("http://localhost:3000/changelog")
    page.should have_selector('.previous_page.disabled')
    find('#page_paginated_section').find('.next_page').click
    page.should have_no_selector('.previous_page.disabled')
    find('#signin').click
    visit("http://localhost:3000/posts")
    page.should have_selector('#page_paginated_section .previous_page.disabled')
    find('#page_paginated_section').find('.next_page').click
    page.should have_no_selector('#page_paginated_section .previous_page.disabled')
    page.should have_selector('#upcomingpage_paginated_section .previous_page.disabled')
    find('#upcomingpage_paginated_section').find('.next_page').click
    page.should have_no_selector('#upcomingpage_paginated_section .previous_page.disabled')
    page.should have_no_selector('#page_paginated_section .previous_page.disabled')
  end
end