class Item < ApplicationRecord
  belongs_to :merchant
    
  has_many :invoice_items
  has_many :invoices, through: :invoice_items 

  validates :name, :description, :unit_price, :updated_at, :created_at, presence: true
  
  def convert_unit_price
    if unit_price.to_s[-2] == "."
      unit_price.to_i.to_s.insert(-3, '.').to_f
    else
      unit_price
    end
  end
end
