require "rails_helper"

RSpec.describe "Registered User links", js: true do
  def authenticate_user
    visit "/"
    fill_in "email", with: "jasmin@turing.io"
    fill_in "password", with: "password"
    click_on "Submit"
  end

  before(:each) do
    @user = create(:user)
    authenticate_user
  end

  scenario "can see their links only" do
    link_1 = create(:link, user_id: @user.id)
    link_2 = create(:link, title: "Facebook", url: "https://facebook.com", user_id: @user.id)
    link_3 = create(:link, title: "Twitter", url: "https://twitter.com", user_id: @user.id)

    visit "/"

    within("#links-list") do
      expect(page).to have_content("Turing")
      expect(page).to have_content("https://turing.io")
      expect(page).to have_content("Facebook")
      expect(page).to have_content("https://facebook.com")
      expect(page).to have_content("Twitter")
      expect(page).to have_content("https://twitter.com")
    end
  end
end
