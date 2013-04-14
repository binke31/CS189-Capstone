class CreateRentPayments < ActiveRecord::Migration
  def change
    create_table :rent_payments do |t|
      t.string :paymentAmount
	  t.integer :routingNumber
	  t.integer :accountNumber
	  t.datetime :paymentDate
	  t.string :firstName
	  t.string :lastName
	  t.string :accountType
	  t.string :savePayment
      t.timestamps
    end
  end
end
