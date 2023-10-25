require 'rails_helper'

RSpec.feature "Timeline", type: :feature do


  scenario "Can Log in with correct email, password, and username" do

    user = FactoryBot.create(:user) # Create a user using FactoryBot

    # Sign in the user through the interface using Capybara
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content(/CHOOSE YOUR LIFEFORM/)
  end

  scenario "Cannot sign in with incorrect email" do

    user = FactoryBot.create(:user) # Create a user using FactoryBot
    

    # Sign in the user through the interface using Capybara
    visit new_user_session_path
    fill_in "Email", with: "micha@gmailcom"
    fill_in "Password", with: "123456"
    click_button "Login"

    expect(page).to have_content(/Invalid Email or password/)
  end

  scenario "Cannot sign in with incorrect email" do

    user = FactoryBot.create(:user) # Create a user using FactoryBot
    

    # Sign in the user through the interface using Capybara
    visit new_user_session_path
    fill_in "Email", with: "jnpmorgangmail.com"
    fill_in "Password", with: "123456"
    click_button "Login"

    expect(page).to have_content(/Invalid Email or password/)
  end

  scenario "Cannot sign in with incorrect password" do

    user = FactoryBot.create(:user) # Create a user using FactoryBot
    

    # Sign in the user through the interface using Capybara
    visit new_user_session_path
    fill_in "Email", with: "micha@gmail.com"
    fill_in "Password", with: "123453"
    click_button "Login"

    expect(page).to have_content(/Invalid Email or password/)
  end 
  
end