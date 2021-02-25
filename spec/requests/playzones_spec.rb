require 'rails_helper'
describe PlayzonesController, type: :request do

  before do
    @plays = FactoryBot.create(:play) 
    let(:user) { create(:user) }
    before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get playzones_path
      expect(response.status).to eq 200
    end
  end
end