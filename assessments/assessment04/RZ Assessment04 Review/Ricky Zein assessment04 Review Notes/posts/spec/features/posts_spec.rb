require 'spec_helper'

def sign_up(username)
  visit "/users/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

def sign_in(username)
  visit "/session/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign In'
end

feature "Creating a post" do
  context "when logged in" do
    before :each do
      sign_up('hello_world')
      visit '/posts/new'
    end

    it "has a new post page" do
      page.should have_content 'New Post'
    end

    it "takes a title and a body" do
      page.should have_content 'Title'
      page.should have_content 'Body'
    end

    it "validates the presence of title and body" do
      fill_in 'Body', with: 'La di da'
      click_button 'Create New Post'
      page.should have_content 'New Post'
    end


    it "redirects to the post show page" do
      fill_in 'Title', with: 'My First Post'
      body_text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
      fill_in 'Body', with: body_text
      click_button "Create New Post"
      page.should have_content 'My First Post'
    end

    context "on failed save" do
      before :each do
        fill_in 'Body', with: 'La di da'
        click_button 'Create New Post'
      end

      it "displays the new post form again" do
        page.should have_content 'New Post'
      end

      it "has a pre-filled form (with the data previously input)" do
        find_field('Body').value.should eq 'La di da'
      end

      it "still allows for a successful save" do
        fill_in 'Title', with: 'My First Post'
        click_button 'Create New Post'
        page.should have_content 'My First Post'
      end
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/posts/new'
      page.should have_content 'Sign In'
    end
  end
end

def make_post(title)
  visit "/posts/new"
  fill_in 'Title', with: title
  body_text = "The body of a post is rad."
  fill_in 'Body', with: body_text
  click_button "Create New Post"
end

feature "Seeing all posts" do
  context "when logged in" do
    before :each do
      sign_up('hello_world')
      make_post('My First Post')
      make_post('My Second Post')
      visit '/posts'
    end

    it "shows all the posts for the current user" do
      page.should have_content 'My First Post'
      page.should have_content 'My Second Post'
    end

    it "shows the current user's username" do
      page.should have_content 'hello_world'
    end

    it "links to each of the posts with the post titles" do
      click_link 'My First Post'
      page.should have_content 'My First Post'
      page.should_not have_content 'My Second Post'
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/posts'
      page.should have_content 'Sign In'
    end
  end

  context "when signed in as another user" do
    before :each do
      sign_up('hello_world')
      click_button 'Sign Out'
      sign_up('goodbye_world')
      make_post('Goodbye cruel world')
      click_button 'Sign Out'
      sign_in('hello_world')
    end

    it "should not show others posts" do
      visit '/posts'
      page.should_not have_content 'Goodbye cruel world'
    end
  end
end

feature "Showing a post" do
  context "when logged in" do
    before :each do
      sign_up('hello_world')
      make_post('Hello, World!')
      visit '/posts'
      click_link 'Hello, World!'
    end

    it "displays the post title" do
      page.should have_content 'Hello, World!'
    end

    it "displays the post body" do
      page.should have_content 'The body of a post is rad.'
    end

    it "displays the author username" do
      page.should have_content 'hello_world'
    end
  end
end

feature "Editing a post" do
  before :each do
    sign_up('hello_world')
    make_post('This is a title')
    visit '/posts'
    click_link 'This is a title'
  end

  it "has a link on the show page to edit a post" do
    page.should have_content 'Edit Post'
  end

  it "shows a form to edit the post" do
    click_link 'Edit Post'
    page.should have_content 'Title'
    page.should have_content 'Body'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Post'
    find_field('Title').value.should eq 'This is a title'
    find_field('Body').value.should eq 'The body of a post is rad.'
  end

  context "on successful update" do
    before :each do
      click_link 'Edit Post'
    end

    it "redirects to the post show page" do
      fill_in 'Title', with: 'A new title'
      click_button 'Update Post'
      page.should have_content 'A new title'
    end
  end
end
