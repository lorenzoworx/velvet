class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :comment_counter

  def increment_comment_count
    post.increment!(:comment_counter)
  end
end
