class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  has_many :plays, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_plays, through: :likes, source: :play

  with_options presence: true do
    validates :nickname, length: { maximum: 20, message: 'は20文字以内で入力してください' }
    validates :password, length: { minimum: 6, message: 'は6文字以上で設定してください' }, on: :create
  end
  validates :profile, length: { maximum: 200, message: 'は200文字以内で入力してください' }
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :position_id
    validates :play_style_id
    validates :play_experience_id
    validates :main_play_area_id
  end
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字の両方を含めて6文字以上で設定してください', on: :create

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :position
  belongs_to :play_style
  belongs_to :play_experience
  belongs_to :main_play_area

  def already_liked?(play)
    likes.exists?(play_id: play.id)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
