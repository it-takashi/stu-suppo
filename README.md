# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|my-image|string|
|introduction|text||
|profile|text||
|subject|string||
|rate|float||
### Association
- has_many :groups_users
- has_many :groups, through: :user_groups
- has_many :messages
- has_many :tweets
- has_many :teaches

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
### Association
- has_many :user_groups
- has_many :users, through: :user_groups
- has_many :messages

## user_groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user

## groupmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|image|string||
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user

## Tweetsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|body|text|null: false|
|image|string||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## tweetmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|image|string||
|tweet_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :tweet
- belongs_to :user

## teachテーブル
|Column|Type|Options|
|------|----|-------|
|title|string||
|image|string||
|body|text||
|user_id|integer|null: false, foreign_key: true|
### Association
- has_many :teach_tags
- has_many :tags, through: :teach_tags

## teach_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string||
|image|string||
|body|text||
|teach_id|integer|null: false, foreign_key: true|
|tag_id|integer|null: false, foreign_key: true|
### Association
- belongs_to : teach
- belongs_to :tag

## tegsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string||
### Association
- has_many :teach_tags
- has_many :teaches, through: :teach_tags