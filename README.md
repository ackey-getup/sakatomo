# README -さかとも！-
![さかともの輪](https://user-images.githubusercontent.com/76201748/108864948-08083800-7636-11eb-93a6-00c40b73b8c8.jpg)
## 概要	
- サッカー好きのためのサッカー専用SNSです。
- このアプリを用いて地域のサッカー仲間を集めることができます。
- 位置情報を用いるので、参加しようとして混乱することはないでしょう。

## URL	
https://sakatomo.herokuapp.com/ <br/>
・Basic認証<br/>
【NAME/PASS】sakatomo / akisoccer

## テスト用アカウント	
- テストユーザー<br/>
【Email/PASS】test@test.com / 123abc

## 利用方法
- ユーザー新規登録をする
- プレーを投稿する
- タイトル、地域、開催場所を検索し地図を表示、グラウンドを選択、開催日時を決定する
- トップページ又はマイページの「参加する！」から一覧に表示されている投稿を探す
- 投稿詳細ページからコメントを送る

## 目指した課題解決	
このアプリで主に地域でのサッカーを盛り上げようと考えました。<br/>
見ず知らずの人とも一緒にプレーすることでより親交を深め、<br/>
お互いがサッカー選手として刺激を与え合える機会を作ろうとしました。<br/>
もしくは地域のクラブがこのアプリを広報活動に用いてもらえたらと考えています。<br/>
また、知らない土地でもこのアプリで仲間を探すことができるでしょう。

## 機能一覧
- ユーザー登録、ログイン機能（devise）
  - ユーザーアイコン設定(carrierwave)
- 投稿機能
  - 画像添付機能（Active Storage）
  - 位置情報保存機能（geocoder）
- コメント機能（Ajax）

## 実装予定の機能	
- ユーザー同士のフォロー機能
- いいね機能
- SNS認証
- 検索機能

## 使用技術
- Ruby 2.6.5p114
- Rails 6.0.3.4
- MySQL 5.6.50
- AWS
  - S3
- Google Maps API
- RSpec

## データベース設計
【ER図】
![スクリーンショット 2021-02-24 0 29 08](https://user-images.githubusercontent.com/76201748/108866239-5a962400-7637-11eb-9c52-654413d5f3fa.png)


# テーブル設計

## usersテーブル

|       Column       |  Type   |   Options   |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| profile            | string  |             |
| position_id        | integer | null: false |
| play_style_id      | integer | null: false |
| play_experience_id | integer | null: false |
| main_play_area_id  | integer | null: false |
| image              | string  |             | 

### Associations

- has_many :plays
- has_many :favorites
- has_many :comments
- has_many :follows

## playsテーブル

|      Column     |    Type    |             Options             |
| --------------- | ---------- | ------------------------------- |
| user            | references | null: false, foreign_keys: true |
| title           | text       | null: false                     |
| published_at    | datetime   | null: false                     |
| detail          | string     |                                 |
| place           | string     | null: false                     |
| area_id         | integer    | null: false                     |
| ground-style_id | integer    | null: false                     |
| latitude        | float      | null: false                     |
| longitude       | float      | null: false                     |

### Associations

- belongs_to :user
- has_many   :comments
- has_many   :favorites

## commentsテーブル

| Column |    Type    |             Options             |
| ------ | ---------- | ------------------------------- | 
| text   | text       | null: false                     |
| user   | references | null: false, foreign_keys: true |
| play   | references | null: false, foreign_keys: true |

### Associations

- belongs_to :user
- belongs_to :play

## followsテーブル

|    Column    |    Type    |          Options                |
| ------------ | ---------- | ------------------------------- |
| following_id | references | null: false, foreign_keys: true |
| followed_id  | references | null: false, foreign_keys: true |

### Associations

- belongs_to :user

## favoritesテーブル

|   Column  |    Type    |            Options              |
| --------- | ---------- | ------------------------------- |
| user      | references | null: false, foreign_keys: true |
| play      | references | null: false, foreign_keys: true |
| play_zone | references | null: false, foreign_keys: true |

### Associations

- belongs_to :user
- belongs_to :play