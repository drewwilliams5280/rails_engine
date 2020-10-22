require 'rails_helper'

describe Merchant do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "class methods" do
    it "find all merchants than include a search term in their name" do
      m1 = create(:merchant, name: "Scooby Doo")
      m2 = create(:merchant, name: "Drewby Doo")
      m3 = create(:merchant, name: "Howdydoody")
      m4 = create(:merchant, name: "Boboblob")
      m5 = create(:merchant, name: "Hello World")
      params = { name: "Doo" }
      merchants = Merchant.find_all(params)
      expect(merchants.count).to eq(3)
      expect(merchants.include?(m1)).to eq(true)
      expect(merchants.include?(m2)).to eq(true)
      expect(merchants.include?(m3)).to eq(true)
      expect(merchants.include?(m4)).to eq(false)
      expect(merchants.include?(m5)).to eq(false)
    end

    it "can get most revenue with quantity params" do 
      m1, m2, m3, m4, m5, m6 = create_list(:merchant, 6)
      merchants = Merchant.all
      20.times do 
        create(:item, merchant: merchants.sample)
      end
      items = Item.all
      30.times do
        create(:invoice, merchant: merchants.sample)
      end
      invoices = Invoice.all
      num = 0
      30.times do
        create(:invoice_item, invoice: invoices[num], item: items.sample)
        num += 1
      end
      invoice_items = InvoiceItem.all
      30.times do 
        create(:transaction, invoice: invoices.sample)
      end
      transactions = Transaction.all
      params = { quantity: 4 }
      test_merchants = Merchant.most_revenue(params).to_a
      expect(test_merchants.size).to eq(4)
      expect(test_merchants[0].revenue > test_merchants[1].revenue).to eq(true)
      expect(test_merchants[1].revenue > test_merchants[2].revenue).to eq(true)
      expect(test_merchants[2].revenue > test_merchants[3].revenue).to eq(true)
    end

    it "can get merchants who have sold the most with quantity params" do 
      m1, m2, m3, m4, m5, m6 = create_list(:merchant, 6)
      merchants = Merchant.all
      20.times do 
        create(:item, merchant: merchants.sample)
      end
      items = Item.all
      30.times do
        create(:invoice, merchant: merchants.sample)
      end
      invoices = Invoice.all
      num = 0
      30.times do
        create(:invoice_item, invoice: invoices[num], item: items.sample)
        num += 1
      end
      invoice_items = InvoiceItem.all
      30.times do 
        create(:transaction, invoice: invoices.sample)
      end
      transactions = Transaction.all
      params = { quantity: 4 }
      test_merchants = Merchant.most_items(params).to_a
      expect(test_merchants.size).to eq(4)
      expect(test_merchants[0].most_items > test_merchants[1].most_items).to eq(true)
      expect(test_merchants[1].most_items > test_merchants[2].most_items).to eq(true)
      expect(test_merchants[2].most_items > test_merchants[3].most_items).to eq(true)
    end

    it "can get total revenue between dates with date params" do 
      m1, m2, m3, m4, m5, m6 = create_list(:merchant, 6)
      merchants = Merchant.all
      
      item1 = create(:item, merchant: merchants.sample)
      item2 = create(:item, merchant: merchants.sample)
      item3 = create(:item, merchant: merchants.sample)
      items = Item.all
      
      invoice1 = create(:invoice, merchant: merchants.sample, created_at: '2012-01-01', status: 'shipped')
      invoice2 = create(:invoice, merchant: merchants.sample, created_at: '2013-01-01', status: 'shipped')
      invoice3 = create(:invoice, merchant: merchants.sample, created_at: '2014-01-01', status: 'shipped')
      invoice4 = create(:invoice, merchant: merchants.sample, created_at: '2015-01-01', status: 'shipped')
      invoice5 = create(:invoice, merchant: merchants.sample, created_at: '2016-01-01', status: 'shipped')
      invoice6 = create(:invoice, merchant: merchants.sample, created_at: '2017-01-01', status: 'shipped')
      invoices = Invoice.all

      ii1 = create(:invoice_item, invoice: invoice1, item: items.sample, quantity: 1, unit_price: 1)
      ii2 = create(:invoice_item, invoice: invoice2, item: items.sample, quantity: 1, unit_price: 2)
      ii3 = create(:invoice_item, invoice: invoice3, item: items.sample, quantity: 1, unit_price: 3)
      ii4 = create(:invoice_item, invoice: invoice4, item: items.sample, quantity: 1, unit_price: 4)
      ii5 = create(:invoice_item, invoice: invoice5, item: items.sample, quantity: 1, unit_price: 5)
      ii6 = create(:invoice_item, invoice: invoice6, item: items.sample, quantity: 1, unit_price: 6)
      ii7 = create(:invoice_item, invoice: invoice6, item: items.sample, quantity: 1, unit_price: 7)
      invoice_items = InvoiceItem.all
      
      t1 = create(:transaction, invoice: invoice1)
      t2 = create(:transaction, invoice: invoice2)
      t3 = create(:transaction, invoice: invoice3)
      t4 = create(:transaction, invoice: invoice4)
      t5 = create(:transaction, invoice: invoice5)
      t6 = create(:transaction, invoice: invoice6)
      t7 = create(:transaction, invoice: invoice6)
      transactions = Transaction.all
      params = { start: '2014-07-07', end: '2016-05-11' }
      test_revenue = Merchant.total_revenue_between_dates(params)
      expect(test_revenue).to be_a Float
      expect(test_revenue).to eq(9.0)
    end
  end

end
