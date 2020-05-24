class CreateSpecificMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :specific_menu_items do |t|
      t.integer :menu_id
      t.integer :menu_item_id
    end
  end
end
