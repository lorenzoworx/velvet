require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET index' do
    before :all do
      @test_user = User.create(name: 'John', photo: 'https://placehold.co/100x100', bio: 'Fullstack developer.')
    end

    it 'should receive a success response.' do
      get user_posts_path(@test_user)
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      get user_posts_path(@test_user)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    before :all do
      @test_user = User.create(name: 'John', photo: 'https://placehold.co/100x100', bio: 'Fullstack developer.')
      @test_post = Post.create(author: @test_user, title: 'Hello World', text: 'This is my first post')
    end

    it 'should receive a success response' do
      get user_post_path(@test_user, @test_post)
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      get user_post_path(@test_user, @test_post)
      expect(response).to render_template(:show)
    end
  end
end
