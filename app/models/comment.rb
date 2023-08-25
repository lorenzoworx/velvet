class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :comment_counter

  after_save :increment_comment_count

  private

  def increment_comment_count
    post.increment!(:comment_counter)
  end
end
