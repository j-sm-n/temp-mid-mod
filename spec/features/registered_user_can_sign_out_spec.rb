require "rails_helper"

RSpec.describe "Registered User" do
  before(:each) do
    User.create( email: "jasmin@turing.io",
                 password: "password", password_confirmation: "password" )

   visit "/"
   fill_in "email", with: "jasmin@turing.io"
   fill_in "password", with: "password"
   click_on "Submit"
  end

  scenario "can sign out" do
    visit "/"

    expect(page).to_not have_link("Sign In")

    click_on "Sign Out"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Log In or Sign Up")
  end
end
