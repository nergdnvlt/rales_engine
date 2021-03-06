class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  scope :successful, -> { where(transactions: { result: 'success' }) }
  scope :unpaid, -> { where.not(id: Transaction.select('transactions.invoice_id').where("transactions.result = 'success'") ) }
end
