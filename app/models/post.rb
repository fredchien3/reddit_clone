class Post < ApplicationRecord
  validates_presence_of :title, :user_id
  validate :has_at_least_one_sub
  
  belongs_to :author,
    class_name: 'User',
    foreign_key: :user_id

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments

  private

  def has_at_least_one_sub
    self.subs.count > 0
  end

end
