class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.float :rate
      t.references :user, foreign_key: true
      t.references :callroom, foreign_key: true
      t.timestamps
    end
  end
end
