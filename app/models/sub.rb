class Sub < ApplicationRecord
  validates_presence_of :title, :user_id
  
end
