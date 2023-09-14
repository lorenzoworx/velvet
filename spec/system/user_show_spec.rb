require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User show page' do
    before do
      @first_user = User.create(name: 'Test', photo: 'https://placehold.co/100x100', bio: 'Fullstack developer')
      @first_post = Post.create(author: @first_user, title: 'Test post 1', text: 'This is test post 1')
      Post.create(author: @first_user, title: 'Test post 2', text: 'This is test post 2')
      Post.create(author: @first_user, title: 'Test post 3', text: 'This is test post 3')
      visit user_path(@first_user)
    end

    it 'Can see the username' do
      expect(page).to have_content(@first_user.name)
    end

    it 'Can see the user profile picture' do
      expect(page).to have_css("img[src='https://placehold.co/100x100']")
    end

    it 'Can see the number of posts written by the user' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'Can see the user bio' do
      expect(page).to have_content(@first_user.bio)
    end

    it 'Can see the user first 3 posts' do
      expect(page).to have_content('Test post 1')
      expect(page).to have_content('Test post 2')
      expect(page).to have_content('Test post 3')
      expect(page).to have_content('This is test post 1')
      expect(page).to have_content('This is test post 2')
      expect(page).to have_content('This is test post 3')
    end

    it 'Can see a show more posts button that display all a users posts' do
      expect(page).to have_link('See all posts')
    end

    it 'Redirects to the post show page when a user post clicked' do
      click_link 'Test post 1'
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
    end

    it 'Redirects to the user post index page' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@first_user))
    end
  end
end
