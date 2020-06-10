class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.decimal :total
      t.date :date
      t.string :status
      t.datetime :delivered_at
    end
  end
end
