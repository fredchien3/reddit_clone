class Post < ApplicationRecord
  validates_presence_of :title, :sub_id, :user_id

  belongs_to :sub
  belongs_to :author,
  class_name: 'User',
  foreign_key: :user_id
end
