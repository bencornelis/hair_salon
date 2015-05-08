require "capybara/rspec"
require "./app"
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("adding a stylist", {:type => :feature}) do
  it("allows the user to add a new stylist and view the stylist in the stylist table") do
    visit("/stylists/new")
    fill_in("name", :with => "Fred")
    click_button("submit")
    expect(page).to have_content("Fred")
  end
end

describe("adding a client", {:type => :feature}) do
  it("allows the user to add a new client and view the client in the client table") do
    visit("/clients/new")
    fill_in("name", :with => "Sally")
    click_button("submit")
    expect(page).to have_content("Sally")
  end
end
