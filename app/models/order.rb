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

  def self.placed?
    all.where.not(:status => "Being Created")
  end

  def self.total
    total = 0
    all.each do |order|
      total = total + order.total.to_d
    end
    return total
  end
end
