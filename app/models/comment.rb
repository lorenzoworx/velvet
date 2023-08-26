class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_comment_count

  private

  def increment_comment_count
    post.increment!(:comment_counter)
  end
end
