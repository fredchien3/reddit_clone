class Sub < ApplicationRecord
  validates_presence_of :title, :user_id
  
  belongs_to :moderator,
    class_name: 'User',
    foreign_key: :user_id

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :post_subs, dependent: :destroy
end
