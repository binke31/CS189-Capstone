class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :monthlyPayment
      t.timestamps
    end
  end
end
