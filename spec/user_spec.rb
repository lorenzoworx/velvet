require 'rails_helper'

describe User, type: :model do
  let(:subject) { User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.') }
  before { subject.save }
  it 'should have name present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have post counter as an integer' do
    subject.post_counter = 2.1
    expect(subject).to_not be_valid
  end

  it 'cannot have post counter less than 0' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it "should return the user's 3 most recent posts" do
    sample_user = User.create(name: 'John', photo: 'https://unsplash.com/photos', bio: 'Fullstack developer.')
    Post.create(author: sample_user, title: 'Hello', text: 'This is my first post')
    Post.create(author: sample_user, title: 'Hello', text: 'This is my second post')
    Post.create(author: sample_user, title: 'Hello', text: 'This is my third post')
    Post.create(author: sample_user, title: 'Hello', text: 'This is my fourth post')

    expect(sample_user.recent_3_posts.size).to eq(3)
    expect(sample_user.recent_3_posts[0].text).to eq('This is my fourth post')
    expect(sample_user.recent_3_posts[1].text).to eq('This is my third post')
    expect(sample_user.recent_3_posts[2].text).to eq('This is my second post')
  end
end
