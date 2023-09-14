require 'rails_helper'

describe Post, type: :model do
  let(:sample_user) { User.create(name: 'John', photo: 'https://placehold.co/100x100', bio: 'Fullstack developer.') }
  let(:sample_post) { Post.create(author: sample_user, title: 'Hello World', text: 'This is my first post') }

  before { sample_post.save }
  it 'should have a title present' do
    sample_post.title = nil
    expect(sample_post).to_not be_valid
  end

  it 'should have comment counter as an integer' do
    sample_post.comment_counter = 2.1
    expect(sample_post).to_not be_valid
  end

  it 'should have a post count of 1' do
    author1 = User.create(name: 'Doe', photo: 'https://placehold.co/100x100', bio: 'Fullstack developer.')
    expect(author1.post_counter).to eq(0)
    Post.create(author: author1, title: 'Hello World', text: 'This is my first post')
    expect(author1.post_counter).to eq(1)
  end

  it 'cannot have comment counter less than 0' do
    sample_post.comment_counter = -1
    expect(sample_post).to_not be_valid
  end

  it 'should have like counter as an integer' do
    sample_post.like_counter = 2.1
    expect(sample_post).to_not be_valid
  end

  it 'cannot have like counter less than 0' do
    sample_post.like_counter = -1
    expect(sample_post).to_not be_valid
  end

  it 'should return the 5 most recent comments' do
    sample_post = Post.create(author: sample_user, title: 'Hello World', text: 'This is my first post')
    Comment.create(post: sample_post, author: sample_user, text: 'This is my first comment')
    Comment.create(post: sample_post, author: sample_user, text: 'This is my 2nd comment')
    Comment.create(post: sample_post, author: sample_user, text: 'This is my 3rd comment')
    Comment.create(post: sample_post, author: sample_user, text: 'This is my 4th comment')
    Comment.create(post: sample_post, author: sample_user, text: 'This is my 5th comment')

    expect(sample_post.recent_5_comments.size).to eq(5)
    expect(sample_post.recent_5_comments[0].text).to eq('This is my 5th comment')
    expect(sample_post.recent_5_comments[1].text).to eq('This is my 4th comment')
    expect(sample_post.recent_5_comments[2].text).to eq('This is my 3rd comment')
    expect(sample_post.recent_5_comments[3].text).to eq('This is my 2nd comment')
    expect(sample_post.recent_5_comments[4].text).to eq('This is my first comment')
  end
end
