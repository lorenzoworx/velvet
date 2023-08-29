require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'should receive a success response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders correct placeholder text' do
      get users_path
      expect(response.body).to include('Here is a list of all the Users')
    end

    it 'renders correct template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    before :all do
      @test_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
    end

    it 'should receive a success response' do
      get user_url(@test_user)
      expect(response).to have_http_status(200)
    end
    it 'renders correct placeholder text' do
      get user_url(@test_user)

      expect(response.body).to include('User details')
    end
    it 'renders correct template' do
      get user_url(@test_user)

      expect(response).to render_template(:show)
    end
  end
end
