require 'rails_helper'

RSpec.describe 'ユーザー情報', type: :system do

  describe "新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー新規登録ができるとき' do 

      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'ニックネーム', with: @user.nickname
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード（6文字以上）', with: @user.password
        fill_in 'パスワード再入力', with: @user.password
        fill_in 'プロフィール', with: @user.profile
        select @user.position.name, from: "user[position_id]"
        select @user.play_style.name, from: "user[play_style_id]"
        select @user.play_experience.name, from: "user[play_experience_id]"
        select @user.main_play_area.name, from: "user[main_play_area_id]"
        # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
        # トップページへ遷移する
        expect(current_path).to eq(root_path)
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end

    end

    context 'ユーザー新規登録ができないとき' do

      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'ニックネーム', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード（6文字以上）', with: ''
        fill_in 'パスワード再入力', with: ''
        fill_in 'プロフィール', with: ''
        select "選択してください", from: "user[position_id]"
        select "選択してください", from: "user[play_style_id]"
        select "選択してください", from: "user[play_experience_id]"
        select "選択してください", from: "user[main_play_area_id]"
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/users')
      end

    end

  end


  describe "ログイン" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    context 'ログインできるとき' do

      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード（6文字以上）', with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移することを確認する
        expect(current_path).to eq(root_path)
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    
    end

    context 'ログインができないとき' do

      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード（6文字以上）', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq(new_user_session_path)
      end
   
    end

  end

end