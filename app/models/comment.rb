class Comment < ApplicationRecord
  validates_presence_of :content, :user_id, :post_id

  belongs_to :post
  belongs_to :author,
    class_name: 'User',
    foreign_key: :user_id

end
