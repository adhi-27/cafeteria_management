class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.date :date
    end
  end
end
