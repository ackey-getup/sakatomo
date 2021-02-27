class Play < ApplicationRecord
  geocoded_by :place
  after_validation :geocode
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: { message: 'を入力してください' } do
    validates :title
    validates :place
    validates :published_at
  end
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :area_id
    validates :ground_style_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ground_style
  belongs_to :area
end
