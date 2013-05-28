class AddBalanceToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :currentBalance
    end
  end
end
