require 'rails_helper'

describe Comment, type: :model do
  it 'should have a comment count of 1' do
    sample_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
    sample_post = Post.create(author: sample_user, title: 'Hello World', text: 'This is my first post')
    sample_comment = Comment.new(post: sample_post, author: sample_user)
    sample_comment.save
    expect(sample_post.comment_counter).to eq(1)
  end
end
