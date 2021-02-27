class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :play, dependent: :destroy

  validates :text, presence: true, length: { maximum: 50, message: 'は50文字以内で送信してください' }
end
