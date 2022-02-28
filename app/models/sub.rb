class Sub < ApplicationRecord
  validates_presence_of :title, :user_id
  
  belongs_to :moderator,
    class_name: 'User',
    foreign_key: :user_id

end
