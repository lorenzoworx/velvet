class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_like_count

  private

  def increment_like_count
    post.increment!(:like_counter)
  end
end
