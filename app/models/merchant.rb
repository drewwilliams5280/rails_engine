class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.find_all(params)
    Merchant.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%")
  end
end
