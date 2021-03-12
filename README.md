# README -さかとも！-
![さかともの輪](https://user-images.githubusercontent.com/76201748/108864948-08083800-7636-11eb-93a6-00c40b73b8c8.jpg)
## 概要	
- サッカー好きのためのサッカー専用SNSです。
- このアプリを用いて地域のサッカー仲間を探すことができます。

## 制作した経緯
幼い頃からサッカー漬けの日々を送ってきた私は、学生時代に友人とサッカーをするときに友人が他校の友人を連れてくるという状況がよくありました。普段交流することのない人と一緒にするプレーはとても刺激的でした。それに同年代であれば試合で対戦することもあるので、これは横の繋がりを強く感じるきっかけになりました。<br/>
そこで、このアプリでは学生のみならず、サッカーを愛するプレーヤー達が仲間探しに使ってもらえたらと考え制作に至りました。

## URL	
http://3.130.10.219/<br/>
- テストユーザー<br/>
【Email】test@test.com<br/>
【PASS】123abc
<img width="1440" alt="sakatomo_top" src="https://user-images.githubusercontent.com/76201748/110926079-4a848100-8367-11eb-86ef-7e01574994c5.png">

## 利用方法
- ユーザー登録をする
- プレーを投稿する
- →タイトル、地域、開催場所を検索し地図を表示、グラウンドを選択、開催日時を決定する
- トップページ又はマイページの「参加する！」から一覧に表示されている投稿を探す
- 投稿詳細ページからコメントを送る
- 使い方を確認する

## 機能一覧
- ユーザー登録、ログイン機能（devise）
  - ユーザー情報編集/削除機能
- 投稿機能
  - 画像添付機能（Active Storage）
  - 位置情報保存機能（geocoder）
  - 投稿情報編集/削除機能
- コメント機能（Ajax）

## 実装予定の機能	
- ユーザー同士のフォロー機能
- いいね機能
- SNS認証
- 検索機能

## 使用技術
- Ruby：2.6.5
- Ruby on Rails：6.0.3.4
- MySQL：5.6.50
- AWS
  - S3
  - EC2
- Docker
- CircleCI
- Google Maps API
- RSpec

## 実行したテスト(RSpec)
- 単体テストコード
  - ユーザー登録
  - プレー投稿
- 結合テストコード
  - ユーザー情報の新規登録/ログイン
  - プレーの投稿/編集/削除/詳細
  - コメント投稿※

## AWS構成図
<img width="834" alt="さかとも構成図" src="https://user-images.githubusercontent.com/76201748/110924803-d3022200-8365-11eb-92a1-88a1e3cfd3c7.png">

## CircleCI
- Githubへのpush時に、RspecとRubocopが自動で実行されます。
- masterブランチへのpushでは、RspecとRubocopが成功した場合、EC2への自動デプロイが実行されます

## データベース設計
【ER図】
![スクリーンショット 2021-02-24 19 04 03](https://user-images.githubusercontent.com/76201748/108986918-07bf7980-76d6-11eb-973a-f1df922f3008.png)


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

### Associations

- belongs_to :user
- belongs_to :play