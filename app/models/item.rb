class Item < ApplicationRecord
  belongs_to :merchant
    
  has_many :invoice_items
  has_many :invoices, through: :invoice_items 
  has_many :transactions, through: :invoices

  validates :name, :description, :unit_price, presence: true

  def self.find_all(params)
    Item.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%")
  end
  
end
