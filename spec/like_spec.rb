require 'rails_helper'
describe Comment, type: :model do
  it 'should have a like count of 1' do
    sample_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
    sample_post = Post.create(author: sample_user, title: 'Hello World', text: 'This is my first post')
    sample_like = Like.new(post: sample_post, author: sample_user)
    sample_like.save
    expect(sample_post.like_counter).to eq(1)
  end
end
