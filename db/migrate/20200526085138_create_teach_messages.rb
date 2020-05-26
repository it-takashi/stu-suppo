class CreateTeachMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :teach_messages do |t|
      t.text :comment,                 null: false
      t.string :image
      t.references :teach, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
