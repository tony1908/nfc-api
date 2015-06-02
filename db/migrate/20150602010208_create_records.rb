class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :user_id
      t.float :cantidad
      t.string :lugar

      t.timestamps null: false
    end
  end
end
