class PlayExperience < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '初心者' },
    { id: 3, name: '1~2年' },
    { id: 4, name: '2~5年' },
    { id: 5, name: '5~8年' },
    { id: 6, name: '8年~10年' },
    { id: 7, name: '10年~' }

]

  include ActiveHash::Associations
  has_many :users

end