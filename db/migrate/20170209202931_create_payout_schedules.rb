class CreatePayoutSchedules < ActiveRecord::Migration
  def change
    create_table :payout_schedules do |t|
      t.integer :day_of_month, unique: true, null: false

      t.timestamps null: false
    end
  end
end
