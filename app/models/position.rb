class Position < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: 'GK' },
    { id: 3, name: 'DF' },
    { id: 4, name: 'MF' },
    { id: 5, name: 'FW' }
  ]

  include ActiveHash::Associations
  has_many :users
end
