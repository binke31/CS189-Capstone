class AddConfirmationToRentPayment < ActiveRecord::Migration
  def change
    change_table(:rent_payments) do |t|
      t.string :confirmationNumber
    end
  end
end
