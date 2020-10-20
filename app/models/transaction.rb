class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, 
            :credit_card_expiration_date, 
            :result, 
            :created_at, 
            :updated_at, 
            presence: true
end
