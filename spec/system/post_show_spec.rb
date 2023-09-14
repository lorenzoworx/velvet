require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'Show Posts Page' do
    before do
      @user = User.create(name: 'Jane', bio: 'Full-stack developer', photo: 'https://placehold.co/100x100')
      @first_post = Post.create(author_id: @user.id, title: 'First post', text: 'First post')
      @comment = Comment.create(author: @user, post: @first_post, text: 'I like it')
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(User.create(name: 'Tom', photo: 'https://placehold.co/100x100', bio: 'Teacher from Ghana.'))
      Like.create(author: @user, post: @first_post)
      visit user_post_path(@user, @first_post)
    end

    it "Can see a post's title" do
      expect(page).to have_content(@first_post.title)
    end

    it 'Can see who wrote the post' do
      expect(page).to have_content("by #{@user.name}")
    end

    it 'Can see how many comments it has' do
      expect(page).to have_content('Comments: 1')
    end

    it 'Can see how many likes it has' do
      expect(page).to have_content('Likes: 1')
    end

    it 'Can see the post body' do
      expect(page).to have_content(@first_post.text)
    end

    it 'Can see the username of each commenter' do
      expect(page).to have_content(@user.name.to_s)
    end

    it 'Can see the comment left by each commenter' do
      expect(page).to have_content("#{@user.name}: #{@comment.text}")
    end
  end
end
