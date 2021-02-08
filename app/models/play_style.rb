class PlayStyle < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '初心者' },
    { id: 3, name: 'のんびり' },
    { id: 4, name: 'エンジョイ' },
    { id: 5, name: '本気' }
]

  include ActiveHash::Associations
  has_many :users

end