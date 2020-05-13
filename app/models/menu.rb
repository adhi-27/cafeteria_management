class Menu < ApplicationRecord
  has_many :menu_items

  validates :name, presence: true
  def self.active_menu
    all.where(active: true).first
  end
end
