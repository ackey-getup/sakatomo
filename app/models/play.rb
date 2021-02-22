class Play < ApplicationRecord
  geocoded_by :place
  after_validation :geocode, if: :place_changed?
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :published_at
    validates :place
    validates :ground_style_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :area_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :published_at
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :ground_style
    belongs_to :area
end