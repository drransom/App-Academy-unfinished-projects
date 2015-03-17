require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content('Sign Up')
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in('Username', with: 'test_user')
      fill_in('Password', with: 'password')
      click_button('Sign Up')
      expect(page).to have_content('test_user')
    end

    it "doesn't accept blank username" do
      visit new_user_url
      fill_in('Username', with: '')
      fill_in('Password', with: 'password')
      click_button('Sign Up')
      expect(page).to have_content('Sign Up')
      expect(page).to have_content("Username can't be blank")
    end

    it "doesn't accept blank password" do
      visit new_user_url
      fill_in('Username', with: 'test_user')
      fill_in('Password', with: '')
      click_button('Sign Up')
      expect(page).to have_content('Sign Up')
      expect(page).to have_content("Password is too short")
    end
  end

end

feature "logging in" do
  before(:each) do
    create_user
    log_out
  end

  it "shows username on the homepage after login" do
    visit new_session_url
    fill_in('Username', with: 'test_user')
    fill_in('Password', with: 'password')
    click_button('Sign In')
    expect(page).to have_content('test_user')
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content("logged in")
  end

  it "doesn't show username on the homepage after logout" do
    create_user
    click_button('Sign Out')
    expect(page).to_not have_content("logged in")
    expect(page).to_not have_content("test_user")
  end

end
