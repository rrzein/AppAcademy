require 'spec_helper'

def sign_up_as_hello_world
  visit "/users/new"
  fill_in "Username", with: 'hello_world'
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

def make_post(title = nil)
  visit "/posts/new"
  fill_in 'Title', with: (title || 'My First Post')
  body_text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  fill_in 'Body', with: body_text
  click_button "Create New Post"
end

feature "Adding tags" do
  before :each do
    sign_up_as_hello_world
  end

  it "has an add tag form on the post show page" do
    make_post
    page.should have_content 'Tag Name'
    page.should have_content 'Add Tag'
  end

  it "shows the post show page on submit" do
    make_post
    fill_in 'Tag Name', with: 'taggerific'
    click_button 'Add Tag'
    page.should have_content 'hello_world'
  end

  it "adds the tag to the tag list on clicking the submit button" do
    make_post
    fill_in 'Tag Name', with: 'taggerific'
    click_button 'Add Tag'
    page.should have_content 'taggerific'
  end
end

def add_tag
  fill_in 'Tag Name', with: 'taggerific'
  click_button 'Add Tag'
end

feature "Deleting tags" do
  before :each do
    sign_up_as_hello_world
  end

  it "displays a remove button next to each tag" do
    make_post
    add_tag
    page.should have_button 'Remove Tag'
  end

  it "shows the post show page on click" do
    make_post
    add_tag
    click_button 'Remove Tag'
    page.should have_content 'hello_world'
  end

  it "removes the tag on click" do
    make_post
    add_tag
    click_button 'Remove Tag'
    page.should_not have_content 'taggerific'
  end
end