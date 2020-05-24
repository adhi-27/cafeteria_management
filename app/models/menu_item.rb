class MenuItem < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true
end
