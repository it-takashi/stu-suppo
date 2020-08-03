# study-support

## 概要
  - ビデオ通話を用いた勉強支援のマッチングアプリです。
  - 勉強を教わることや教えることができます。また、学んだことを投稿することができます。
  - インフラにAWSを用いてssl化をしています。

## 本番環境
 https://stu-suppo.com/  かんたんログインでお試しすることができます。

## 制作背景

このアプリでは、教える、教わるを通して双方に成長できたらと思いこのアプリを作成しました。  皆さんは、勉強が分からなくて、諦めたことはありますか。もしかしたら、誰かに聞けば、もう一度勉強を頑張ってみようと思えるかもしれません。  私の前職では、勉強を諦めていた子供も1対1の個別で基礎を教え、成績を伸ばすことができました。また、先生側の視点として、相手が分かったと理解することや、頑張っている姿を見ると、嬉しい気持ちや応援したくなるます。  このアプリで先生側も教えることのやりがいを感じてもらえればと願っています。

## 使用技術（開発環境）
- Ruby 2.5.1, Rails 5.0.7.2
- Nginx, unicorn
- MySQL
- SCSS, jQuery
- Capistrano
- AWS （EC2, S3, VPC, Route53, ACM, ALB）

## 機能一覧
- ユーザー登録、編集
  - deviseを使用
  - すでに使われているnameを非同期で確認することができる
  -  画像アップロードにCarrierWaveを使用
- ユーザー詳細情報
  - 自分が投稿した記事一覧を表示
- ログイン・ログアウト機能
  - かんたんログイン機能
- 投稿機能（tweets,callroomsテーブル）
  - 投稿編集、削除機能
  - 投稿一覧、投稿詳細表示機能
  - 画像アップロードにCarrierWaveを使用
  - ページネーション機能にKaminariを使用
  - ビデオ機能( callroomのみ)
    - ビデオ通話には、外部api( skyway )を使用
    - 着信機能,発信機能
    - 着信拒否、発信キャンセル機能
- コメント機能 ( messages,repliesテーブル )
  - 非同期でコメント投稿ができる
  - 自動更新 ( messagesテーブルのみ )
- レビュー機能 ( reviewsテーブル )
  - jquery.ratyを使用
  - ビデオ通話終了後に起動
  - 非同期validationにjQuery Validation Pluginを使用

## 工夫したところ

- 着信処理
  どのようにしたら着信があることを示せるか考えて実装したことです。statusカラムの変化を自動更新で読み取り、モーダルで誰から着信があるのか表示することで着信処理としました。

- 教わることの終了のタイミング
  jqueryでビデオ通話終了のタイミングで発火し、student_idが空になるようにしました。もし不具合がある場合には、先生側は、いつでも通信解除することができるようにしました。

## 今後実装したい機能
- 検索機能の実装
- タグ機能の実装
- いいね機能の実装
- フォロー、フォロワー機能の実装
- テストコードを書くこと
- dockerの導入
- circle ciの導入

##  DB設計

<img width="1070" alt="er" src="https://user-images.githubusercontent.com/64767604/89150600-e3654980-d599-11ea-883d-27fab3026b3a.png">