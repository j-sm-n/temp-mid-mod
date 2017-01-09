require "rails_helper"

RSpec.describe "Unathenticated User" do
  scenario "can see sign up form" do
    visit "/"
    click_on "Sign Up"

    within_fieldset('User') do
      expect(page).to have_field("Email address")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password confirmation")
    end
  end

  scenario "can sign up" do
    visit "/"
    click_on "Sign Up"
    fill_in "Email address", with: "jasmin@turing.io"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create account"

    expect(current_path).to eq(links_path)
    expect(current_user.email).to eq("jasmin@turing.io")
  end

  scenario "can't sign up with an email that has already been taken" do
    User.create( email: "jasmin@turing.io",
                 password: "password", password_confirmation: "password" )
    visit "/"
    click_on "Sign Up"
    fill_in "Email address", with: "jasmin@turing.io"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create account"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Email is already taken.")
  end

  scenario "can't sign up with mismatched passwords" do
    visit "/"
    click_on "Sign Up"
    fill_in "Email address", with: "jasmin@turing.io"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "pass"
    click_on "Create account"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Passwords must match.")
  end
end
