class Item < ApplicationRecord
  belongs_to :merchant
    
  has_many :invoice_items
  has_many :invoices, through: :invoice_items 

  def convert_unit_price
    unit_price.to_s.insert(-3, '.').to_f
  end
end
