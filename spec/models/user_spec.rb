require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do

    context '新規登録できるとき' do
      
      it "必要な値が揃えば登録できること" do
        expect(@user).to be_valid
      end
      
      it "パスワードと確認用パスワードが一致していれば登録できること" do
        @user.password = @user.password_confirmation
        expect(@user).to be_valid
      end

    end

    context 'ユーザー新規登録できないとき' do
      
      it "ニックネームが空では登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it "ニックネームが21文字以上では登録できない" do
        @user.nickname = "あいうえおあいうえおあいうえおあいうえおあいうえおあ"
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは20文字以内で入力してください")
      end

      it "メールアドレスが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "重複したメールアドレスが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it "emailに@が含まれていない場合登録できない" do
        @user.email = "abc.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it "パスワードが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "パスワードが5文字以下では登録できない" do
        @user.password = "123ab"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it "パスワードが英字のみの場合登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて6文字以上で設定してください")
      end

      it "パスワードが数字のみの場合登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて6文字以上で設定してください")
      end

      it "パスワードが全角の場合登録できない" do
        @user.password = "１２３ａｂｃ"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて6文字以上で設定してください")
      end

      it "確認用パスワードが空では登録できない" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include()
      end

      it "ポジションが未選択だと登録できない" do
        @user.position_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("ポジションを選択してください")
      end

      it "プレースタイルが未選択だと登録できない" do
        @user.play_style_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("プレースタイルを選択してください")
      end

      it "プレー年数が未選択だと登録できない" do
        @user.play_experience_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("プレー年数を選択してください")
      end

      it "プレー地域が未選択だと登録できない" do
        @user.main_play_area_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("プレー地域を選択してください")
      end

    end
    
  end

end