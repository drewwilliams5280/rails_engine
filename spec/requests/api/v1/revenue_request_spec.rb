require 'rails_helper'

describe "Revenue API" do
  it "sends total revenue between dates" do
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

      get '/api/v1/revenue?start=2014-07-07&end=2016-05-11'

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to be_a Hash
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('revenue')
      expect(json_response[:data]).to have_key(:attributes)

      revenue = json_response[:data][:attributes][:revenue]
      expect(revenue).to eq(9)
    end

    it "sends total for a merchant" do
      m1, m2, m3, m4, m5, m6 = create_list(:merchant, 6)
        merchants = Merchant.all
        
        item1 = create(:item, merchant: merchants.sample)
        item2 = create(:item, merchant: merchants.sample)
        item3 = create(:item, merchant: merchants.sample)
        items = Item.all
        
        invoice1 = create(:invoice, merchant: m1, created_at: '2012-01-01', status: 'shipped')
        invoice2 = create(:invoice, merchant: m1, created_at: '2013-01-01', status: 'shipped')
        invoice3 = create(:invoice, merchant: m1, created_at: '2014-01-01', status: 'shipped')
        invoice4 = create(:invoice, merchant: m2, created_at: '2015-01-01', status: 'shipped')
        invoice5 = create(:invoice, merchant: m2, created_at: '2016-01-01', status: 'shipped')
        invoice6 = create(:invoice, merchant: m2, created_at: '2017-01-01', status: 'shipped')
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
  
        get "/api/v1/merchants/#{m1.id}/revenue"
  
        expect(response).to be_successful
        require 'pry'; binding.pry
      end
  end