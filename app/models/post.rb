class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :post_counter
  has_many :like
  has_many :comment

  def recent_5_comments
    comment.order(created_at: :desc).limit(5)
  end

  def increment_post_count
    author.increment!(:post_counter)
  end
end
