require 'spec_helper'

feature "Sign up" do
  before :each do
    visit "/users/new"
  end

  it "has a user sign up page" do
    page.should have_content "Sign Up"
  end

  it "takes a username and password" do
    page.should have_content "Username"
    page.should have_content "Password"
  end

  it "validates the presence of the user's username and password" do
    fill_in "Username", with: 'hello_world'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
  end

  it "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'abcde'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
  end

  it "logs the user in and redirects him to posts index on success" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'abcdef'
    click_button 'Sign Up'
    page.should have_content 'hello_world'
  end
end

def sign_up_as_hello_world
  visit "/users/new"
  fill_in "Username", with: 'hello_world'
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/session/new"
    page.should have_content "Sign In"
  end

  it "takes a username and password" do
    visit "/session/new"
    page.should have_content "Username"
    page.should have_content "Password"
  end

  it "returns to sign in on failure" do
    visit "/session/new"
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'hello'
    click_button "Sign In"
    # return to sign-in page
    page.should have_content "Sign In"
  end

  it "takes a user to posts index on success" do
    sign_up_as_hello_world
    # add button to sign out on index page
    click_button 'Sign Out'

    # Sign in as newly created user
    visit "/session/new"
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'abcdef'
    click_button "Sign In"
    page.should have_content "hello_world"
  end
end

feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_hello_world
    page.should have_button 'Sign Out'
  end

  it "logs a user out on click" do
    sign_up_as_hello_world
    click_button 'Sign Out'
    visit '/posts'
    # redirect to login page
    page.should have_content 'Sign In'
  end
end