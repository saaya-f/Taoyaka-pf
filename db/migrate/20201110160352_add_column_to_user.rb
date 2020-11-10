class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :work, :integer
    add_column :users, :profile_image_id, :string
    add_column :users, :is_deleted, :boolean, default: false
  end
end
