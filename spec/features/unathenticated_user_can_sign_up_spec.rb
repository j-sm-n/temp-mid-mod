require "rails_helper"

RSpec.describe "Unathenticated User" do
  scenario "can see sign up form" do
    visit "/"
    click_on "Sign Up"

    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")
  end

  scenario "can sign up" do
    visit "/"
    click_on "Sign Up"
    fill_in "user[email]", with: "jasmin@turing.io"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Submit"

    expect(current_path).to eq(links_path)
    expect(current_user.email).to eq("jasmin@turing.io")
  end

  scenario "can't sign up with an email that has already been taken" do
    User.create( email: "jasmin@turing.io",
                 password: "password", password_confirmation: "password" )
    visit "/"
    click_on "Sign Up"
    fill_in "user[email]", with: "jasmin@turing.io"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Email is already taken.")
  end

  scenario "can't sign up with mismatched passwords" do
    visit "/"
    click_on "Sign Up"
    fill_in "user[email]", with: "jasmin@turing.io"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "pass"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Passwords must match.")
  end
end
