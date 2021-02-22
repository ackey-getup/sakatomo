# README -さかとも-

## 概要	
必要なものはボール1つ。
地元でも知らない土地でもこのアプリを使うことでサッカー仲間を探すことができます。
一緒にプレーする仲間を増やして大好きなサッカーをより楽しもう。

## URL	
デプロイ済みURL：

## テスト用アカウント	


## 利用方法	
プレーを投稿する
タイトル、地域、開催場所を検索し地図を表示、グラウンドを選択、開催日時を決定する
「サッカーに参加する」から一覧に表示されている投稿を探す
投稿詳細ページからコメントを送る

## 目指した課題解決	
このアプリで主に地域でのサッカーを盛り上げようと考えた。
見ず知らずの人とも一緒にプレーすることでより親交を深め、
お互いがサッカー選手として刺激を与え合える機会を作ろことができたらと思った。
また、知らない土地でもこのアプリで仲間を探すことができる。

## 洗い出した要件	
スプレッドシートにまとめた要件定義を、マークダウンで記述しなおしましょう。

## 実装した機能についてのGIFと説明	
実装した機能について、それぞれどのような特徴があるのか列挙しましょう。GIFを添えることで、イメージがしやすくなります。

## 実装予定の機能	
洗い出した要件の中から、今後実装予定のものがあれば記述しましょう。

## データベース設計
【ER図】
- さかともER.dio

## ローカルでの動作方法	
git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記述しましょう。
- macOS Catalina 10.15.7
- Ruby on Rails 6.0.0


# テーブル設計

## usersテーブル

|       Column       |  Type   |   Options   |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| birthday           | date    | null: false |
| position           | integer |             |
| play_style         | integer | null: false |
| play_experience    | integer |             |
| main_play_area     | integer | null: false |
| image              | string  |             | 

### Associations

- has_many :plays
- has_many :favorites
- has_many :comments
- has_many :follows

## playsテーブル

|    Column    |    Type    |            Options              |
| ------------ | ---------- | ------------------------------- |
| user         | references | null: false, foreign_keys: true |
| time         | integer    | null: false                     |
| detail       | string     |                                 |
| place        | string     | null: false                     |
| ground-style | string     | null: false                     |
| latitude     | float      | null: false                     |
| longitude    | float      | null: false                     |

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