require 'rails_helper'

describe "Items / ID / Merchant API" do
  it "sends the merchant associated with a specific item" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item = create(:item, merchant: merchant_1)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data].count).to eq(3)
  
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:id]).to be_an(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end