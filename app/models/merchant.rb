class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.find_all(params)
    Merchant.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%")
  end

  def self.most_revenue(params)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order("revenue DESC")
    .limit(params[:quantity])
  end

  def self.most_items(params)
    select("merchants.*, SUM(invoice_items.quantity) AS most_items")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .group(:id)
    .order("most_items DESC")
    .limit(params[:quantity])
  end

  def self.total_revenue_between_dates(params)
    start_date = DateTime.iso8601(params[:start])
    end_date = DateTime.iso8601(params[:end]).end_of_day

    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .where(invoices: { created_at: [start_date..end_date]})
    .group(:id)
    .sum(&:revenue)
  end
end
