class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.string :comment
      t.string :image
      t.references :tweet, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
