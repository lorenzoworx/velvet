require 'rails_helper'

RSpec.describe "Post", type: :system do
  describe "Post index page" do
    before do
      @user = User.create(name: 'Jane', bio: 'Full-stack developer', photo: 'https://placehold.co/100x100')
      @first_post = Post.create(author_id: @user.id, title: 'First post', text: 'First post')
      @comment = Comment.create(author: @user, post: @first_post, text: 'I like it')
      Like.create(author: @user, post: @first_post)
      visit user_posts_path(@user)
    end

    it "Can see the user's profile picture" do
      expect(page).to have_css("img[src='https://placehold.co/100x100']")
    end

    it "Can see the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "Can see the number of posts the user has written" do
      expect(page).to have_content('Number of posts: 1')
    end

    it "Can see a post's title" do
      expect(page).to have_content(@first_post.title)
    end

    it "Can see the post's body" do
      expect(page).to have_content(@first_post.text)
    end

    it "Can see the first few comments on a post" do
      expect(page).to have_content("#{@user.name}: #{@comment.text}")
    end

    it "Can see how many comments a post has" do
      expect(page).to have_content("Comments: 1")
    end

    it "Can see how many likes a post has" do
      expect(page).to have_content("Likes: 1")
    end

    it "Redirects to a posts show page when a post is clicked" do
      click_link 'First post'
      expect(page).to have_current_path(user_post_path(@user, @first_post))
    end
  end
end
