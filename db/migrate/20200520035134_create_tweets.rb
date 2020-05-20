class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :title,              null: false
      t.text :body,              null: false
      t.string :image,              null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
