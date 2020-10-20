require 'rails_helper'

describe Item do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "instance methods" do
    it "can convert unit_price to place decimal for price" do
      merchant = Merchant.create!(id: 1, name: 'drew', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
      item = Item.create!(merchant: merchant, name: "itemname", description:  "best item", unit_price: 37484, created_at: Faker::Date.between(from: '2014-09-23', to: '2020-09-25'), updated_at: Faker::Date.between(from: '2014-09-23', to: '2020-09-25'))
      item2 = Item.create!(merchant: merchant, name: "itemname", description:  "best item", unit_price: 37484.99, created_at: Faker::Date.between(from: '2014-09-23', to: '2020-09-25'), updated_at: Faker::Date.between(from: '2014-09-23', to: '2020-09-25'))
      expect(item.convert_unit_price).to eq(374.84)
      expect(item2.convert_unit_price).to eq(37484.99)
    end
  end
end