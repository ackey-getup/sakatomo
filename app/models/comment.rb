class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :play, dependent: :destroy

  validates :text, presence: true
end
