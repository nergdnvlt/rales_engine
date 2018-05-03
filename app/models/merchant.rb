
class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  default_scope { order(:id) }

  def self.most_items(quantity)
    unscoped
      .select('merchants.*, sum(invoice_items.quantity) AS item_count')
      .joins(invoices: :invoice_items)
      .group(:id)
      .order('item_count DESC')
      .limit(quantity)
  end

  def self.most_revenue(quantity)
    unscoped
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items)
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end
  
  def self.revenue_by_date(filter)
    joins(invoices: [:invoice_items, :transactions])
    .where(filter)
    .merge(Transaction.unscoped.successful)
    .sum('quantity * unit_price')
  end

  def revenue(filter = {})
    invoices.joins(:invoice_items, :transactions)
      .where(filter)
      .merge(Transaction.unscoped.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
