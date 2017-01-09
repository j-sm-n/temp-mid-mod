require "rails_helper"

RSpec.describe "Unathenticated User" do
  scenario "can see login or sign up prompt" do
    visit "/"

    expect(page).to have_content("Log In or Sign Up")
    expect(page).to have_content("Welcome to URL Lockbox!")
  end
end
