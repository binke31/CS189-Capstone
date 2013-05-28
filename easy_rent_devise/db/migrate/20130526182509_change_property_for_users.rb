class ChangePropertyForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :property_info, :property_id
  end
end
