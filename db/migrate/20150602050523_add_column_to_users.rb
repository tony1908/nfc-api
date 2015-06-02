class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :push, :string
  end
end
