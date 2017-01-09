require "rails_helper"

RSpec.describe "Authenticated User can edit links", js: :true do
  def authenticate_user(user)
    visit "/"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Submit"
  end

  before(:each) do
    @user = create(:user)

    authenticate_user(@user)
  end

  scenario "Edit a link" do
    link = create(:link, user_id: @user.id)
    visit "/"
    within("#link-1") do
      click_on "Edit"
    end
    fill_in "Title:", with: "Turing School of Software & Design"
    click_on "Update Link"

    expect(current_path).to eq(links_path)
    within('#links-list') do
      expect(page).to have_text("Turing School of Software & Design")
      expect(page).to have_text("http://turing.io")
    end
  end

  # scenario "forgets to add a title" do
  #   visit "/"
  #   fill_in "URL:", with: "http://turing.io"
  #   click_on "Add Link"
  #
  #   expect(page).to have_content("Title can't be blank URL")
  #   expect(page).to_not have_content("Turing")
  #   expect(page).to_not have_content("http://turing.io")
  # end
  #
  # scenario "forgets to add an url" do
  #   visit "/"
  #   fill_in "Title:", with: "Turing"
  #   click_on "Add Link"
  #
  #   expect(page).to have_content("Url can't be blank")
  #   expect(page).to_not have_content("Turing")
  #   expect(page).to_not have_content("http://turing.io")
  # end
  #
  # scenario "url submitted is invalid" do
  #   visit "/"
  #   fill_in "Title:", with: "Turing"
  #   fill_in "URL:", with: "turing.io"
  #   click_on "Add Link"
  #
  #   expect(page).to have_content("Url is invalid")
  #   expect(page).to_not have_content("Turing")
  #   expect(page).to_not have_content("http://turing.io")
  # end
end
