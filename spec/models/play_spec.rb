require 'rails_helper'

RSpec.describe Play, type: :model do
  before do
    @play = FactoryBot.build(:play)
  end

  describe "プレーを投稿する" do
    
    context '投稿できる' do
      
      it "必要な値が揃えば投稿できる" do
        expect(@play).to be_valid
      end

      it "主コメントがなくても投稿できる" do
        @play.detail = nil
        expect(@play).to be_valid
      end

    end

    context '投稿できない' do
      
      it "プレータイトルが空では投稿できない" do
        @play.title = nil
        @play.valid?
        expect(@play.errors.full_messages).to include("タイトルを入力してください")
      end

      it "地域が未選択では投稿できない" do
        @play.area_id = 1
        @play.valid?
        expect(@play.errors.full_messages).to include("地域を選択してください")
      end

      it "開催場所が空では投稿できない" do
        @play.place = nil
        @play.valid?
        expect(@play.errors.full_messages).to include("開催場所を入力してください")
      end

      it "グラウンドが未選択では投稿できない" do
        @play.ground_style_id = 1
        @play.valid?
        expect(@play.errors.full_messages).to include("グラウンドを選択してください")
      end

      it "開催日時が空では投稿できない" do
        @play.published_at = nil
        @play.valid?
        expect(@play.errors.full_messages).to include("開催日時を入力してください")
      end

    end
  
  end

end
