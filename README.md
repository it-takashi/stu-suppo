# 機能一覧
- ユーザー登録、編集
  - deviseを使用
  - すでに使われているnameを非同期で確認することができる
  -  画像アップロードにCarrierWaveを使用
- ログイン・ログアウト機能
  - かんたんログイン機能
- 投稿機能（tweets,callroomsテーブル）
  - 投稿編集、削除機能
  - 投稿一覧、投稿詳細表示機能
  - 画像アップロードにCarrierWaveを使用
  - ページネーション機能にKaminariを使用
- ビデオ機能
  - ビデオ通話には、外部api( skyway )を使用
  - 着信機能,発信機能( callroomのみ )
- コメント機能 ( messages,repliesテーブル )
  - 非同期でコメント投稿ができる
  - 自動更新 ( messagesテーブルのみ )
- レビュー機能 ( reviewsテーブル )
  - jquery.ratyを使用
  - ビデオ通話終了後に起動

# DB設計

<img width="1070" alt="er" src="https://user-images.githubusercontent.com/64767604/89150600-e3654980-d599-11ea-883d-27fab3026b3a.png">