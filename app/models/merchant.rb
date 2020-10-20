class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, :created_at, :updated_at, presence: true
end
