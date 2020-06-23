class Menu < ApplicationRecord
  has_many :specific_menu_items

  validates :name, presence: true
  def self.active_menu
    find_by(active: true)
  end
end
