require 'rails_helper'

RSpec.feature "Timeline", type: :feature do


  scenario "Can sign up with correct email, password, and username" do

    # Sign Up the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "micha@gmail.com"
    fill_in "Username", with: "micha1"
    fill_in "Password", with: "112358"
    fill_in "Password confirmation", with: "112358"

    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"

    expect(page).to have_content(/Avatar/) 
    # expect(page).to have_content(/Back Story/)
  end

  scenario "Cannot sign up with invalid email" do

    # Sign Up the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "michagmail.com"
    fill_in "Username", with: "micha1"
    fill_in "Password", with: "112358"
    fill_in "Password confirmation", with: "112358"

    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"

    expect(page).to have_content(/Email is invalid/)
  end

  scenario "Cannot sign up with invalid email" do

    # Sign Up the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "micha@gmailcom"
    fill_in "Username", with: "micha1"
    fill_in "Password", with: "112358"
    fill_in "Password confirmation", with: "112358"

    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"

    expect(page).to have_content(/Email is invalid/)
  end
  scenario "Cannot sign up with invalid password" do

    # Sign in the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "micha@gmail.com"
    fill_in "Username", with: "micha1"
    fill_in "Password", with: "11235"
    fill_in "Password confirmation", with: "11235"

    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"
    
    expect(page).to have_text("Password is too short (minimum is 6 characters)")
    # expect(page).to have_content(/\nPassword is too short (minimum is 6 characters)\nCLICK HERE TO CREATE ACCOUNT Log in/)
  end

  scenario "Cannot sign up with invalid password" do

    # Sign in the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "micha@gmail.com"
    fill_in "Username", with: "micha1"
    fill_in "Password", with: "This is > 12 characters For Fouki Sake"
    fill_in "Password confirmation", with: "This is > 12 characters For Fouki Sake"

    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"
    expect(page).to have_text("Password is too long (maximum is 12 characters)")
    # expect(page).to have_content(/\nPassword is too long (maximum is 12 characters)\nCLICK HERE TO CREATE ACCOUNT Log in/)
  end

  scenario "Cannot sign up leaving the username box blank" do

    # Sign in the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "micha@gmail.com"
    fill_in "Username", with: ""
    fill_in "Password", with: "112358"
    fill_in "Password confirmation", with: "112358"
    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"

    expect(page).to have_content(/Username can't be blank/)
  end

  scenario "Cannot sign up with an already existing email" do
    user = FactoryBot.create(:user) 

    # Sign in the user through the interface using Capybara
    visit new_user_registration_path
    fill_in "Email", with: "michaela@gmail.com"
    fill_in "Username", with: "ffsmichaela"
    fill_in "Password", with: "11235811"
    fill_in "Password confirmation", with: "112358"
    # check "user_isAgeOver13"
    # check "user_agreed_to_terms"
    click_button "Sign up"

    expect(page).to have_content(/Email has already been taken Password/)
  end

    # scenario "Cannot sign up if age is less than 13" do
    # user = FactoryBot.create(:user) 

    # # Sign in the user through the interface using Capybara
    # visit new_user_registration_path
    # fill_in "Email", with: "johnuy@gmail.com"
    # fill_in "Username", with: "12345dfggd6"
    # fill_in "Password", with: "12346f"
    # check "user_agreed_to_terms"
    # click_button "Sign up"
    

    # expect(page).to have_content(/Age must be over 13/)
    # end

    # scenario "Cannot sign up if terms and conitions is not checked" do
    # user = FactoryBot.create(:user) 

    # # Sign in the user through the interface using Capybara
    # visit new_user_registration_path
    # fill_in "Email", with: "johnuy@gmail.com"
    # fill_in "Username", with: "12345dfggd6"
    # fill_in "Password", with: "12346f"
    # check "user_isAgeOver13"
    # click_button "Sign up"
    

    # expect(page).to have_content(/Must agree to terms and conditions/)
    #   end
end