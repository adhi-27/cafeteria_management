class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true
  validates :price, presence: true

  def self.specific_menu_items(menu_id)
    all.where(menu_id: menu_id)
  end
end
