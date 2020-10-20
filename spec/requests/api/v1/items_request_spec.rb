require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    Merchant.create!(id: 1, name: 'drew', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
    Merchant.create!(id: 2, name: 'drewbob', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
    create_list(:item, 3)
    get '/api/v1/items'
    
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "get specific item details" do
    Merchant.create!(id: 1, name: 'drew', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')      
    Merchant.create!(id: 2, name: 'drewbob', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
    create(:item)
    item = Item.first
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
      
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)
  
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  end
end