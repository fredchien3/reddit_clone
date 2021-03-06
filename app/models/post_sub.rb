class PostSub < ApplicationRecord
  validates :sub_id, uniqueness: { scope: :post_id }
  
  belongs_to :post
  belongs_to :sub
end
