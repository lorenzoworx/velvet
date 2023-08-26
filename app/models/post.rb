class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :post_counter
  has_many :like
  has_many :comment
  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_5_comments
    comment.order(created_at: :desc).limit(5)
  end

  after_save :increment_post_count

  private

  def increment_post_count
    author.increment!(:post_counter)
  end
end
