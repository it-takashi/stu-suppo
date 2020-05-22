class ChangeColumnToNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :tweets, :image, true
  end
end
