require "rails_helper"

RSpec.describe "Registered User" do
  before(:each) do
    User.create( email: "jasmin@turing.io",
                 password: "password", password_confirmation: "password" )
  end

  scenario "can sign in" do
    visit "/"

    expect(current_path).to eq(login_path)

    fill_in "email", with: "jasmin@turing.io"
    fill_in "password", with: "password"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome back, jasmin@turing.io!")
  end

  scenario "can't leave email blank" do
    visit "/"
    fill_in "password", with: "password"
    click_on "Submit"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid login")
  end

  scenario "can't leave password blank" do
    visit "/"
    fill_in "email", with: "jasmin@turing.io"
    click_on "Submit"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid login")
  end
end
