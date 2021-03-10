require 'rails_helper'

# RSpec.describe 'コメント投稿', type: :system do
# before do
# @play = FactoryBot.create(:play)
# @comment = Faker::Lorem.sentence
# end
# it 'ログインしたユーザーはプレー詳細ページでコメント投稿できる', js: true do
# ログインする
# visit new_user_session_path
# fill_in 'メールアドレス', with: @play.user.email
# fill_in 'パスワード（6文字以上）', with: @play.user.password
# find('input[name="commit"]').click
# expect(current_path).to eq(root_path)
# プレー詳細ページに遷移する
# visit play_path(@play)
# フォームに情報を入力する
# fill_in 'comment_text', with: @comment
# コメントを送信すると、Commentモデルのカウントが1上がることを確認する
# find('input[name="commit"]').click
# 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
# expect(page).to have_content @comment
# end
# end
