require 'rails_helper'
describe PlaysController, type: :request do
  before do
    @play = FactoryBot.create(:play)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
  end
end
