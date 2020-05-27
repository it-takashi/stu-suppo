class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :comment
      t.string :image
      t.references :teach, foreign_key: true
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
