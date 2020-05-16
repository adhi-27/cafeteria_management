class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def self.confirm(order_id, role, total)
    order = find_by(id: order_id)
    order.total = total
    if role == "Customer"
      order.status = "Confirmed"
    else
      order.status = "Delivered"
      order.delivered_at = DateTime.now
    end
    order.save!
  end

  def self.confirmed?
    all.where.not(:status => "Being Created")
  end
end
