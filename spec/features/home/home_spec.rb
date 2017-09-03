require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  scenario "Visit Home page" do
    visit root_path
    expect(page.find('h2')).to have_content("Welcome")
  end
end
