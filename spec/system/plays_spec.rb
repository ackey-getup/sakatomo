require 'rails_helper'

RSpec.describe 'プレー投稿', type: :system do
  describe '新規プレー投稿' do
    before do
      @user = FactoryBot.create(:user)
      @play = FactoryBot.build(:play)
      @plays = Play.all
    end

    context '投稿ができるとき' do
      it 'ログインしたユーザーは新規投稿できる' do
        # ログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード（6文字以上）', with: @user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # 新規投稿ページへのリンクがあることを確認する
        expect(page).to have_content('サッカーをする！')
        # 投稿ページに移動する
        visit new_play_path
        # フォームに情報を入力する
        fill_in 'プレータイトル', with: @play.title
        select @play.area.name, from: 'play[area_id]'
        fill_in 'play[place]', with: @play.place
        expect { find('input[value="地図上検索"]').click }
        select @play.ground_style.name, from: 'play[ground_style_id]'
        fill_in 'コメント（任意）', with: @play.detail
        # 送信するとplayモデルのカウントが1上がることを確認する
        expect { find('input[name="commit"]').click }.to change { Play.count }.by(1)
        # 一覧ページに遷移する
        expect(current_path).to eq(list_path)
        # 一覧には先ほど投稿した内容が存在することを確認する
        expect(page).to have_link("#{@play.title}@#{@play.place}", href: play_path(@plays.ids))
      end
    end

    context '投稿ができないとき' do
      it 'ログインしていないと新規投稿ページに遷移できない' do
        # トップページに遷移する
        visit root_path
        # 新規投稿ページへ飛ぼうとするとログインページに遷移される
        visit new_play_path
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe '投稿プレー編集' do
    before do
      @play1 = FactoryBot.create(:play)
      @play2 = FactoryBot.create(:play)
    end

    context '編集できるとき' do
      it 'ログインしたユーザーは自分が投稿したプレーの編集ができる' do
        # プレー1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @play1.user.email
        fill_in 'パスワード（6文字以上）', with: @play1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # プレー1に「編集」ボタンがあることを確認する
        visit list_path
        visit play_path(@play1)
        expect(page).to have_link '編集', href: edit_play_path(@play1)
        # 編集ページへ遷移する
        visit edit_play_path(@play1)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        expect(find('#play_title').value).to eq(@play1.title)
        expect(find('#play_area_id').value).to eq @play1.area.id.to_s
        expect(find('#address').value).to eq(@play1.place)
        expect(find('#play_ground_style_id').value).to eq @play1.ground_style.id.to_s
        expect(find('#play_detail').value).to eq(@play1.detail)
        # 投稿内容を編集する
        fill_in 'プレータイトル', with: "#{@play1.title}編集テスト"
        select @play1.area.name, from: 'play[area_id]'
        fill_in 'play[place]', with: "#{@play1.place}編集テスト"
        expect { find('input[value="地図上検索"]').click }
        select @play1.ground_style.name, from: 'play[ground_style_id]'
        fill_in 'コメント', with: "#{@play1.detail}編集テスト"
        # 編集してもplayモデルのカウントは変わらないことを確認する
        expect { find('input[name="commit"]').click }.to change { Play.count }.by(0)
        # 一覧ページには先ほど変更した内容のプレーが存在することを確認する（テキスト）
        visit list_path
        expect(page).to have_link(@play1.title.to_s, href: play_path(@play1))
      end
    end

    context '編集できないとき' do
      it 'ログインしたユーザーは自分以外が投稿したプレーの編集画面には遷移できない' do
        # プレー1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @play1.user.email
        fill_in 'パスワード（6文字以上）', with: @play1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # プレー2に「編集」ボタンがないことを確認する
        expect(play_path(@play2)).to have_no_link '編集', href: edit_play_path(@play2)
      end

      it 'ログインしていないとプレーの編集画面には遷移できない' do
        # プレー1に「編集」ボタンがないことを確認する
        expect(play_path(@play1)).to have_no_link '編集', href: edit_play_path(@play1)
        # プレー2に「編集」ボタンがないことを確認する
        expect(play_path(@play2)).to have_no_link '編集', href: edit_play_path(@play2)
      end
    end
  end

  describe '投稿プレー削除' do
    before do
      @play1 = FactoryBot.create(:play)
      @play2 = FactoryBot.create(:play)
    end

    context '削除できるとき' do
      it 'ログインしたユーザーは自らが投稿したプレーの削除ができる' do
        # プレー1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @play1.user.email
        fill_in 'パスワード（6文字以上）', with: @play1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # プレー1に「削除」ボタンがあることを確認する
        visit play_path(@play1)
        expect(page).to have_link '削除', href: play_path(@play1)
        # 投稿を削除するとレコードの数が1減ることを確認する
        expect { page.find_link('削除', href: play_path(@play1)).click }.to change { Play.count }.by(-1)
        # 一覧ページに遷移する
        visit list_path
        # 一覧ページにはプレー1の内容が存在しないことを確認する
        expect(page).to have_no_content(@play1)
      end
    end

    context '削除できないとき' do
      it 'ログインしたユーザーは自分以外が投稿したプレーの削除ができない' do
        # プレー1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @play1.user.email
        fill_in 'パスワード（6文字以上）', with: @play1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # プレー2に「削除」ボタンが無いことを確認する
        expect(play_path(@play2)).to have_no_link '削除', href: edit_play_path(@play2)
      end

      it 'ログインしていないとプレーの削除ボタンがない' do
        # プレー1に「削除」ボタンが無いことを確認する
        expect(play_path(@play1)).to have_no_link '削除', href: edit_play_path(@play1)
        # プレー2に「削除」ボタンが無いことを確認する
        expect(play_path(@play2)).to have_no_link '削除', href: edit_play_path(@play2)
      end
    end
  end

  describe '投稿プレー詳細' do
    before do
      @play = FactoryBot.create(:play)
    end

    it 'ログインしたユーザーはプ詳細ページに遷移してコメント投稿欄が表示される' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @play.user.email
      fill_in 'パスワード（6文字以上）', with: @play.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに遷移する
      visit play_path(@play)
      # 詳細ページにプレーの内容が含まれている
      expect(page).to have_content(@play.title.to_s)
      expect(page).to have_content(@play.area.name.to_s)
      expect(page).to have_content(@play.place.to_s)
      expect(page).to have_content(@play.ground_style.name.to_s)
      expect(page).to have_content(@play.detail.to_s)
      # コメント用のフォームが存在する
      expect(page).to have_selector 'form'
    end

    it 'ログインしていないユーザーは詳細ページに飛ぼうとするとログインページに遷移する' do
      # 詳細ページに遷移する
      visit play_path(@play)
      # ログインページに遷移する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
