class PlayExperience < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '初心者' },
    { id: 3, name: '1~5年' },
    { id: 4, name: '5~10年' },
    { id: 5, name: '10~15年' },
    { id: 6, name: '15~20年' },
    { id: 7, name: '20年~' }

]

  include ActiveHash::Associations
  has_many :users

end