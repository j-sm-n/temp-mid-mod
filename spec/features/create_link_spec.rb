require "rails_helper"

RSpec.describe "Authenticated User can create links", js: :true do
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
    fill_in "Title:", with: "Turing"
    fill_in "URL:", with: "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
    end
  end

  scenario "forgets to add a title" do
    visit "/"
    fill_in "URL:", with: "http://turing.io"
    click_on "Add Link"

    expect(page).to have_content("Title can't be blank URL")
    expect(page).to_not have_content("Turing")
    expect(page).to_not have_content("http://turing.io")
  end

  scenario "forgets to add an url" do
    visit "/"
    fill_in "Title:", with: "Turing"
    click_on "Add Link"

    expect(page).to have_content("Url can't be blank")
    expect(page).to_not have_content("Turing")
    expect(page).to_not have_content("http://turing.io")
  end

  scenario "url submitted is invalid" do
    visit "/"
    fill_in "Title:", with: "Turing"
    fill_in "URL:", with: "turing.io"
    click_on "Add Link"

    expect(page).to have_content("Url is invalid")
    expect(page).to_not have_content("Turing")
    expect(page).to_not have_content("http://turing.io")
  end
end
