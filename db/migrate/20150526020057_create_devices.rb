class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :device_t
      t.integer :nip

      t.timestamps null: false
    end
  end
end
