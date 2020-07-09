class CreateCallrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :callrooms do |t|
      t.string :title,              null: false
      t.text :body,                 null: false
      t.string :image
      t.integer :status,  null: false
      t.references :user, foreign_key: true
      t.references :student
      t.timestamps
    end
  end
end

# statusが0のとき 非公開
# statusが1のとき 公開
# statusが2のとき 公開 studentが入ってきた
# statusが3のとき 部屋の作成 studentがいる