require "rails_helper"

RSpec.describe "Authenticated User can create links", :js => :true do
  def authenticate_user
    visit "/"
    fill_in "email", with: "jasmin@turing.io"
    fill_in "password", with: "password"
    click_on "Submit"
  end

  before(:each) do
    User.create( email: "jasmin@turing.io",
                 password: "password", password_confirmation: "password" )

   authenticate_user
  end

  scenario "Create a new link" do
    visit "/"
    fill_in "Title:", :with => "Turing"
    fill_in "URL:", :with => "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
    end

  end
end
