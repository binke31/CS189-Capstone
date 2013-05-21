class AddUseridToRentPayments < ActiveRecord::Migration
  def change
    change_table(:rent_payments) do |t|
      t.integer :user_id
    end
  end
end
