class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def self.confirm(order_id)
    order = find_by(id: order_id)
    order.status = "Confirmed"
    order.save!
  end

  def self.confirmed?
    all.where.not(:status => "Being Created")
  end
end
