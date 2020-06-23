class CreateCallrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :callrooms do |t|
      t.string :title,              null: false
      t.text :body,                 null: false
      t.string :image,              null: false
      t.boolean :release, default: false, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
