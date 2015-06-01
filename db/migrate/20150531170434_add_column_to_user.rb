class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :sign_token, :string
  end
end
