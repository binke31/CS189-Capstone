class AddRentDueDateToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.integer :rentDueDay
    end
  end
end
