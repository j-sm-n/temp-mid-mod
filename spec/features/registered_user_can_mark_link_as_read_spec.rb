require "rails_helper"

RSpec.describe "Registered User links", js: true do
  def authenticate_user
    visit login_path
    fill_in "email", with: "jasmin@turing.io"
    fill_in "password", with: "password"
    click_on "Submit"
  end

  before(:each) do
    @user = create(:user)
    authenticate_user
  end

  # scenario "can mark a link as read" do
  #   link_1 = create(:link, user_id: @user.id)
  #   link_2 = create(:link, title: "Facebook", url: "https://facebook.com", user_id: @user.id)
  #   link_3 = create(:link, title: "Twitter", url: "https://twitter.com", user_id: @user.id)
  #
  #   visit "/"
  #   within first(".link") do
  #     click_on "Mark as Read"
  #   end
  #
  #   page.reset!
  #
  #   within first(".link") do
  #     expect(page).to have_content("true")
  #   end
  # end
end
