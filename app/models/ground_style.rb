class GroundStyle < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: 'クレイ' },
    { id: 3, name: '人工芝' },
    { id: 4, name: '荒れた芝' },
    { id: 5, name: '天然芝' }
]

  include ActiveHash::Associations
  has_many :plays

end