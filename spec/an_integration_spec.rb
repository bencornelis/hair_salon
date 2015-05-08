require "capybara/rspec"
require "./app"
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("adding a stylist", {:type => :feature}) do
  it("allows the user to add a new stylist and view the stylist in the stylist table") do
    visit("/")
    fill_in("stylist_name", :with => "Fred")
    click_button("add_stylist")
    expect(page).to have_content("Fred")
  end
end

describe("adding a client", {:type => :feature}) do
  it("allows the user to add a new client and view the client in the client table") do
    visit("/")
    fill_in("client_name", :with => "Sally")
    click_button("add_client")
    expect(page).to have_content("Sally")
  end
end

describe("deleting a stylist", {:type => :feature}) do
  it("allows user to delete a stylist") do
    test_stylist = Stylist.new({:name => "John"})
    test_stylist.save
    visit("/stylists/#{test_stylist.id}")
    click_button("delete")
    expect(page).to have_no_content("John")
  end
end

describe("deleting a client", {:type => :feature}) do
  it("allows user to delete a client") do
    test_client = Client.new({:name => "Jim"})
    test_client.save
    visit("/clients/#{test_client.id}")
    click_button("delete")
    expect(page).to have_no_content("Jim")
  end
end

describe("changing a stylist's name", {:type => :feature}) do
  it("allows user to change a stylist's name") do
    test_stylist = Stylist.new({:name => "John"})
    test_stylist.save
    visit("/stylists/#{test_stylist.id}")
    fill_in("stylist_name", :with => "Jonny")
    click_button("patch")
    expect(page).to have_content("Jonny")
  end
end

describe("changing a client's name", {:type => :feature}) do
  it("allows user to change a client's name") do
    test_client = Client.new({:name => "John"})
    test_client.save
    visit("/clients/#{test_client.id}")
    fill_in("client_name", :with => "Jonny")
    click_button("patch")
    expect(page).to have_content("Jonny")
  end
end

describe("adding a client to a stylist", {:type => :feature}) do
  it("allows user to add an unassigned client to a stylist from the stylist's page") do
    test_stylist = Stylist.new({:name => "John"})
    test_stylist.save
    test_client = Client.new({:name => "Sally"})
    test_client.save
    visit("/stylists/#{test_stylist.id}")
    select(test_client.name, :from => "clients")
    click_button("add_client")
    expect(page).to have_content("Sally")
  end
end
