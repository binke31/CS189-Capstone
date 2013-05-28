class AddFieldsToProperty < ActiveRecord::Migration
  def change
    change_table :properties do |t|
      t.string :rentDivisionEnabled
      t.string :rentDivisions
    end
  end
end
