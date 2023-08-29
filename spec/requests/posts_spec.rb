require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET index' do
    before :all do
      @test_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
    end

    it 'should receive a success response.' do
      get user_posts_path(@test_user)
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      get user_posts_path(@test_user)
      expect(response).to render_template(:index)
    end

    it 'renders correct placeholder text' do
      get user_posts_path(@test_user)
      expect(response.body).to include('Here is a list of posts made by the same user')
    end
  end

  describe 'GET show' do
    before :all do
      @test_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
      @test_post = Post.create(author: @test_user, title: 'Hello World', text: 'This is my first post')
    end

    it 'should receive a success response' do
      get user_post_path(@test_user, @test_post)
      expect(response).to have_http_status(200)
    end

    it 'renders correct placeholder text' do
      get user_post_path(@test_user, @test_post)
      expect(response.body).to include('User post details')
    end

    it 'renders correct template' do
      get user_post_path(@test_user, @test_post)
      expect(response).to render_template(:show)
    end
  end
end
