class Like < ApplicationRecord
  belongs_to :user
  belongs_to :play
  validates_uniqueness_of :play_id, scope: :user_id
end
