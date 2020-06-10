class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :category
      t.text :description
      t.decimal :price
    end
  end
end
