class AddPropertyToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :property_info
    end
  end
end
